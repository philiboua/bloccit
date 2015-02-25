class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.moderator?
        scope.all
      else
        user.nil? ? [] : scope.where(user_id: user.id)
      end
    end
  end

  def destroy?
    user.present? && (record.user == user || user.admin? || user.moderator?)
  end
  
end

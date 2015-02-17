class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  belongs_to :topic
  has_one :summary

  default_scope { order('created_at DESC') }

  # def visible_to(user)
  #   user.admin? ? all : where(user_id: user.id)
  # end
end

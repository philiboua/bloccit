class RemoveSummaryFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :summary_id, :integer
  end
end

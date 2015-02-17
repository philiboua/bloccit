class AddSummaryToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :summary_id, :integer
  end
end

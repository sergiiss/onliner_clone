class AddRankToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :rank, :integer
  end
end

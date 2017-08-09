class RemoveColumnToPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :categorie
  end
end

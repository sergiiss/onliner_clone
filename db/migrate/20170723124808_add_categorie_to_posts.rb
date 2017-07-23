class AddCategorieToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :categorie, :string
  end
end

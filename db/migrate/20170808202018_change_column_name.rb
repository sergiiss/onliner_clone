class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :categories, :categorie, :name
  end
end

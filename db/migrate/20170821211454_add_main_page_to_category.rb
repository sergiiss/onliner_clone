class AddMainPageToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :main_page, :boolean
  end
end

class RemoveNameFromPostCategories < ActiveRecord::Migration
  def change
    remove_column :post_categories, :name, :string
  end
end

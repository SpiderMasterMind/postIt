class AddPostAndCategoryFks < ActiveRecord::Migration
  def change
    add_column :post_categories, :category_id, :integer
    add_column :post_categories, :post_id, :integer
  end
end

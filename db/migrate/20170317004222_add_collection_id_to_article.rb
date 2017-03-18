class AddCollectionIdToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :collection_id, :integer, null: false
  end
end

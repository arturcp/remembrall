class RemoveAuthorName < ActiveRecord::Migration[5.0]
  def change
    remove_column :articles, :author_name
  end
end

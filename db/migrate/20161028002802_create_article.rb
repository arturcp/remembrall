class CreateArticle < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :url
      t.string :author_name
      t.string :title
      t.string :description
      t.string :image_url
      t.string :favicon

      t.timestamps null: false
    end
  end
end

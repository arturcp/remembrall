class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.belongs_to :user, index: true
      t.belongs_to :article, index: true
      t.timestamps
    end
  end
end

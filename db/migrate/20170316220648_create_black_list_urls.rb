class CreateBlackListUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :black_list_urls do |t|
      t.integer :collection_id
      t.string :pattern
    end
  end
end

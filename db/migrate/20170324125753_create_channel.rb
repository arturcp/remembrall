class CreateChannel < ActiveRecord::Migration[5.0]
  def change
    create_table :channels do |t|
      t.string :collection_id
      t.string :name
      t.string :slack_channel_id

      t.timestamps
    end
  end
end

class CreateCollection < ActiveRecord::Migration[5.0]
  def change
    create_table :collections do |t|
      t.string :name
      t.string :slack_token
      t.string :slug
      t.integer :user_id

      t.timestamp
    end
  end
end

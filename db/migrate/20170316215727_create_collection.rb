class CreateCollection < ActiveRecord::Migration[5.0]
  def change
    create_table :collections do |t|
      t.string :name
      t.string :slug
      t.string :team_id
      t.string :bot_user_id
      t.string :bot_access_token

      t.timestamp
    end
  end
end

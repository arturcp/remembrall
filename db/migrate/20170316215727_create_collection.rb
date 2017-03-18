class CreateCollection < ActiveRecord::Migration[5.0]
  def change
    create_table :collections do |t|
      t.string :name
      t.string :slack_api_token
      t.string :slug
      t.string :team_id

      t.timestamp
    end
  end
end

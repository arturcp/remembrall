class CreateUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :slack_id
      t.string :name
      t.string :avatar_url
    end

    add_index "users", ["slack_id"], name: "index_users_on_slack_id", using: :btree
  end
end

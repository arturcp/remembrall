class AddChannelIdToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :channel_id, :integer
  end
end

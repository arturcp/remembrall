require 'slack'

desc 'Import users from slack'
task import_slack_users: :environment do
  client = Slack::Client.new(token: ENV['SLACK_TOKEN'])

  client.users_list['members'].each do |slack_user|
    User.find_or_create_by(slack_id: slack_user['id']).tap do |user|
      user.name = slack_user['name']
      user.avatar_url = slack_user['profile']['image_32']
    end.save!
  end

  puts 'done.'
end

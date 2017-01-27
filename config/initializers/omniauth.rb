OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, ENV.fetch('SLACK_KEY'), ENV.fetch('SLACK_SECRET'), scope: 'identity.basic', team: ENV.fetch('TEAM_ID'), name: :sign_in_with_slack
  provider :slack, ENV.fetch('SLACK_KEY'), ENV.fetch('SLACK_SECRET'), scope: 'team:read,users:read,identify,users:read.email'
end

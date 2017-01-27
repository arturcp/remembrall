OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, ENV.fetch('SLACK_KEY'), ENV.fetch('SLACK_SECRET'), scope: 'identity.basic', name: :sign_in_with_slack
  provider :slack, ENV.fetch('SLACK_KEY'), ENV.fetch('SLACK_SECRET'), scope: 'users:read,users:read.email,identify'

  # team: ENV.fetch('TEAM_ID'),
end

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, ENV.fetch('SLACK_KEY'), ENV.fetch('SLACK_SECRET'), scope: 'identity.basic', team: ENV.fetch('TEAM_ID')
end

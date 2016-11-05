require 'rails_helper'

describe User do
  describe '.default' do
    let(:user) { User.default }

    it 'returns the default user' do
      expect(user.name).to eq(User::DEFAULT_NAME)
      expect(user.avatar_url).to eq(User::DEFAULT_AVATAR)
    end
  end
end

require 'rails_helper'

RSpec.describe SlackEvents::ChannelRename, type: :model do
  describe '#execute' do
    let(:channel) { create(:channel) }
    let(:event) { described_class.new(channel.collection, params) }

    context 'when channel already exists' do
      let(:params) do
        {
          event: {
            channel: {
              name: 'new name',
              id: channel.slack_channel_id
            }
          }
        }
      end

      it 'changes the name of the channel' do
        event.execute
        expect(channel.reload.name).to eq('new name')
      end

      it 'calls the method to update channel' do
        expect(event).to receive(:update_channel_name).with(channel, 'new name')
        event.execute
      end
    end

    context 'when channel does not exist' do
      let(:params) do
        {
          event: {
            channel: {
              name: 'My Channel',
              id: '12345B'
            }
          }
        }
      end

      it 'does not call the method to update channel' do
        expect(event).not_to receive(:update_channel_name)
        event.execute
      end
    end
  end
end

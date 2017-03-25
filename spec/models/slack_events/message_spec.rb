require 'rails_helper'

RSpec.describe SlackEvents::Message, type: :model do
  let(:channel) { create(:channel) }
  let(:collection) { channel.collection }
  let(:params) do
    {
      slack_event: {
        event: {
          text: text
        }
      },
      event: {
        channel: channel.slack_channel_id
      }
    }
  end

  let(:message) { described_class.new(collection, params) }

  describe '#urls' do
    context 'when text is nil' do
      let(:text) { nil }

      it 'returns an empty list' do
        expect(message.urls).to be_empty
      end
    end

    context 'when message is blank' do
      let(:text) { '' }

      it 'returns an empty list' do
        expect(message.urls).to be_empty
      end
    end

    context 'when message does not contain urls' do
      let(:text) { 'this is a valid message with no urls' }

      it 'returns an empty list' do
        expect(message.urls).to be_empty
      end
    end

    context 'when message contains one link' do
      let(:text) { 'check out this page: <http://www.google.com.br>' }

      it 'returns a list with one url' do
        expect(message.urls).to eq(['http://www.google.com.br'])
      end
    end

    context 'when message contains many urls' do
      let(:text) { 'check out <http://www.google.com.br> and <http://www.youse.com.br>' }

      it 'returns a list of urls' do
        expect(message.urls).to eq(['http://www.google.com.br', 'http://www.youse.com.br'])
      end
    end
  end

  describe '#hashtags' do
    context 'when there are hashtags' do
      let(:text) { '#tag <http://www.google.com.br> #ficaADica #eaí' }

      it 'captures all hashtags from the message' do
        expect(message.hashtags).to match_array(['tag', 'ficaADica', 'eaí'])
      end
    end

    context 'when there are anchors in the url' do
      let(:text) { '#tag <http://www.google.com.br#anchor1> #ficaADica' }

      it 'ignores hashtags that are part of the url' do
        expect(message.hashtags).to match_array(['tag', 'ficaADica'])
      end
    end

    context 'when there are no hashtags' do
      let(:text) { '<http://www.google.com.br#test>' }

      it 'returns an empty array' do
        expect(message.hashtags).to be_empty
      end
    end
  end

  describe '#execute' do
    context 'when the message is invalid' do
      context 'and there are no urls' do
        let(:text) { '' }

        it 'does not call the article service' do
          expect(ArticleService).not_to receive(:new)
          message.execute
        end
      end

      context 'and the event is for a deleted message' do
        let(:params) do
          {
            slack_event: {
              event: {
                subtype: 'message_deleted',
                text: ''
              }
            },
            event: {
              channel: channel.slack_channel_id
            }
          }
        end

        it 'does not call the article service' do
          expect(ArticleService).not_to receive(:new)
          message.execute
        end
      end
    end

    context 'when the message is valid' do
      let(:article) { create(:youse) }

      context 'and user already exists' do
        let(:params) do
          {
            slack_event: {
              event: {
                text: '<http://www.google.com.br>',
                user: article.user.slack_id
              }
            },
            event: {
              channel: channel.slack_channel_id
            }
          }
        end

        it 'does not create a new user' do
          expect(User).not_to receive(:save_profile)
          message.execute
        end

        it 'calls the article service' do
          expect(ArticleService).to receive(:new).once.with(channel, article.user.slack_id).and_call_original
          message.execute
        end
      end

      context 'and user does not exist' do
        let(:new_user) do
          {
            user: {
              name: 'Edgard',
              profile: {
                image_72: 'fake_image.png'
              }
            }
          }
        end

        let(:params) do
          {
            slack_event: {
              event: {
                text: '<http://www.google.com.br>',
                user: 'FAKEID123'
              }
            },
            event: {
              channel: channel.slack_channel_id,
              user: 'FAKEID123'
            }
          }
        end

        before { allow(SlackAPI).to receive(:user_info).and_return(new_user) }

        it 'creates a new user' do
          expect(User).to receive(:save_profile).with(
            {
              collection: channel.collection,
              id: 'FAKEID123',
              name: 'Edgard',
              avatar: 'fake_image.png'
            }
          )

          message.execute
        end

        it 'calls the article service' do
          expect(ArticleService).to receive(:new).once.with(channel, 'FAKEID123').and_call_original
          message.execute
        end
      end

      context 'and channel does not exist' do
        let(:params) do
          {
            slack_event: {
              event: {
                text: '<http://www.google.com.br>',
                user: 'FAKEID123'
              }
            },
            event: {
              channel: 'FAKE_CHANNEL'
            }
          }
        end

        let(:new_channel) do
          {
            channel: {
              name: 'my new channel'
            }
          }
        end

        before { allow(SlackAPI).to receive(:channel_info).with(channel.collection.bot_access_token, 'FAKE_CHANNEL').and_return(new_channel) }

        it 'creates a new channel' do
          expect { message.execute }.to change { Channel.count }.by(1)
        end

        it 'calls the article service' do
          expect(ArticleService).to receive(:new).once.and_call_original
          message.execute
        end
      end
    end
  end
end

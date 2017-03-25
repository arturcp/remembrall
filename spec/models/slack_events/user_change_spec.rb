require 'rails_helper'

RSpec.describe SlackEvents::UserChange, type: :model do
  let(:channel) { create(:channel) }
  let(:collection) { channel.collection }
  let(:event) { described_class.new(collection, params) }

  describe '#new_user?' do
    context 'when event is of the type "user_change"' do
      context 'and no user is set on the params' do
        let(:params) { { event: { type: 'user_change' } } }

        it 'returns false' do
          expect(event).not_to be_new_user
        end
      end

      context 'and the user is set on the params' do
        let(:params) { { event: { type: 'user_change', user: { id: 'CBED1' } } } }

        context 'and the user exists in the database' do
          before { allow(User).to receive(:exists?).and_return(true) }

          it 'returns false' do
            expect(event).not_to be_new_user
          end
        end

        context 'and the user does not exit in the database' do
          before { allow(User).to receive(:exists?).and_return(false) }

          it 'returns true' do
            expect(event).to be_new_user
          end
        end

      end
    end

    context 'when event is not of the type "user_change"' do
      context 'and user is not set in the params' do
        let(:params) { { event: { type: 'message' } } }

        it 'returns false' do
          expect(event).not_to be_new_user
        end
      end

      context 'and user is set in the params' do
        let(:params) { { event: { type: 'message', user: 'ABC123' } } }

        context 'and the user exists in the database' do
          before { allow(User).to receive(:exists?).and_return(true) }

          it 'returns true' do
            expect(event).not_to be_new_user
          end
        end

        context 'and the user does not exist in the database' do
          before { allow(User).to receive(:exists?).and_return(false) }

          it 'returns false' do
            expect(event).to be_new_user
          end
        end
      end
    end
  end

  describe '#execute' do
    let(:params) { { event: { type: 'user_change' } } }

    context 'and the user is new' do
      before do
        allow(event).to receive(:new_user?).and_return(true)
        allow(SlackAPI).to receive(:user_info).and_return({ user: { name: 'John Doe', profile: { image: 'fake_image.png' } } })
      end

      it 'calls the Slack API to fetch user data' do
        expect(SlackAPI).to receive(:user_info)
        event.execute
      end

      it 'creates a new user' do
        expect { event.execute }.to change { User.count }.by(1)
      end
    end

    context 'and the user is not new' do
      before { allow(event).to receive(:new_user?).and_return(false) }

      it 'does not call the Slack API to fetch user data' do
        expect(SlackAPI).not_to receive(:user_info)
        event.execute
      end

      it 'saves the user profile' do
        expect(User).to receive(:save_profile).once
        event.execute
      end

      it 'creates a new user' do
        expect { event.execute }.to change { User.count }.by(1)
      end
    end
  end
end

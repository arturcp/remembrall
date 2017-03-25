require 'rails_helper'

RSpec.describe ArticleService, type: :service do
  describe '#article_from_message' do
    let(:user) { create(:john) }
    let(:channel) { create(:channel) }
    let(:collection) { channel.collection }
    let(:service) { described_class.new(channel, user.slack_id) }
    let(:images) { [double(src: 'remembrall.png')] }
    let(:message) { SlackEvents::Message.new(collection, { slack_event: { event: { text: text } } }) }

    let(:page_content) do
      double(
        title: 'Remembrall',
        description: 'The best link database of the web',
        favicon: 'fav.ico',
        images: images
      )
    end

    before do
      allow(Page).to receive(:read).and_return(page_content)
    end

    context 'when message does not have urls' do
      let(:text) { 'hello world' }

      it 'does not save a new article' do
        expect { service.article_from_message(message) }.to change { Article.count }.by(0)
      end
    end

    context 'when message has urls' do
      context 'and url is a mention' do
        let(:text) { 'Talk to me, <@john>' }

        it 'does not save a new article' do
          expect { service.article_from_message(message) }.to change { Article.count }.by(0)
        end
      end

      context 'and url is a site' do
        let(:text) { "take a look at this amazing website: <http://www.google.com|google> #{hashtags}" }

        context 'and message has hashtags' do
          let(:hashtags) { '#takeALook #IT' }

          it 'saves a new article' do
            expect { service.article_from_message(message) }.to change { Article.count }.by(1)
          end

          it 'tags the article with the hashtags' do
            articles = service.article_from_message(message)
            expect(articles.last.tags.map(&:name)).to match_array(['takeALook', 'IT'])
          end
        end

        context 'and message has no hastags' do
          let(:hashtags) { '' }

          it 'saves a new article' do
            expect { service.article_from_message(message) }.to change { Article.count }.by(1)
          end

          it 'does not tag the article' do
            articles = service.article_from_message(message)
            expect(articles.last.tags).to be_empty
          end
        end
      end

      context 'and url is blacklisted' do
        let(:text) { "take a look at this amazing website: <http://#{URL::BLACK_LIST.first}>" }

        it 'does not save a new article' do
          expect { service.article_from_message(message) }.to change { Article.count }.by(0)
        end
      end

      context 'and url is already saved in the database' do
        let!(:youse) { create(:youse) }
        let(:text) { "take a look at this amazing website: <#{youse.url}>" }

        it 'does not save a new article' do
          expect { service.article_from_message(message) }.to change { Article.count }.by(0)
        end
      end

      context 'page image' do
        let(:text) { 'take a look at this amazing website: <http://www.google.com>' }
        let(:articles) { service.article_from_message(message) }

        context 'when page has images' do
          let(:images) { [double(src: 'fake_image.png')] }

          it 'creates an article with the page image' do
            expect(articles.first.image_url).to eq('fake_image.png')
          end
        end

        context 'when page has no images' do
          let(:images) { [] }

          it 'creates an article with the default image' do
            expect(articles.first.image_url).to eq(Article::DEFAULT_IMAGE_URL)
          end
        end
      end
    end
  end
end

require 'rails_helper'

describe Article do
  describe '#author' do
    context 'when article has no user' do
      let(:article) { create(:culture) }

      it 'returns the default user' do
        expect(article.author.name).to eq(User::DEFAULT_NAME)
      end
    end

    context 'when article has user' do
      let(:article) { create(:youse) }

      it 'returns the user' do
        expect(article.author.name).to eq('John Doe')
      end
    end
  end

  context 'duplicated urls' do
    before { create(:youse) }
    let(:article) { Article.new(url: 'http://www.youse.com.br') }

    it 'is invalid if url already exists' do
      expect(article).not_to be_valid
    end

    it 'prevents a duplicated url to be saved' do
      article.save
      expect(article.errors[:url]).to include('has already been taken')
    end
  end

  describe '.build' do
    before do
      allow(Page).to receive(:read).and_return(page_content)
    end

    let!(:youse) { create(:youse) }
    let(:images) { [double(src: 'remembrall.png')] }
    let(:user_id) { 'USR1' }
    let(:page_content) do
      double(
        title: 'Remembrall',
        description: 'The best link database of the web',
        favicon: 'fav.ico',
        images: images
      )
    end

    context 'when url is black listed' do
      it 'does not save the article' do
        expect { Article.build(user_id, URL::BLACK_LIST[0]) }.to change { Article.count }.by(0)
      end
    end

    context 'when url is already saved' do
      it 'does not save the article' do
        expect { Article.build(user_id, youse.url) }.to change { Article.count }.by(0)
      end
    end

    context 'when url is valid' do
      context 'and page has images' do
        it 'saves the article in the database' do
          expect { Article.build(user_id, "http://www.fakeurl.com/#{SecureRandom.uuid}") }.to change { Article.count }.by(1)
        end
      end

      context 'and page has no images' do
        let(:images) { [] }

        it 'saves the article in the database' do
          expect { Article.build(user_id, "http://www.fakeurl.com/#{SecureRandom.uuid}") }.to change { Article.count }.by(1)
        end
      end
    end

    context 'with tags' do
      it 'includes tags on the article' do
        article = Article.build(user_id, "http://www.fakeurl.com/#{SecureRandom.uuid}", ['tag1', 'tag2'])
        expect(article.tags.map(&:name)).to match_array(['tag1', 'tag2'])
      end
    end
  end

  describe '.from_message' do
    let(:user_id) { 'USR1' }
    before do
      allow(Page).to receive(:read).and_return(Struct.new(:title, :description, :favicon, :images).new('title', 'description', 'fav.ico', []))
    end

    context 'when urls are valid' do
      it 'saves the articles in the database' do
        message = Message.new('Look how nice! <http://www.google.com.br> and <http://www.heroku.com|heroku>')
        expect { Article.from_message(message: message, user_id: user_id) }.to change { Article.count }.by(2)
      end
    end

    context 'when url is actually a mention' do
      it 'saves the articles in the database' do
        message = Message.new('Talk to me, <@john>')
        expect { Article.from_message(message: message, user_id: user_id) }.to change { Article.count }.by(0)
      end
    end

    context 'with tags' do
      it 'includes tags on the article' do
        message = Message.new('Look how nice! <http://www.heroku.com|heroku> #bestLink #weRock')
        article = Article.from_message(message: message, user_id: user_id).last
        expect(article.tags.map(&:name)).to match_array(['bestLink', 'weRock'])
      end
    end
  end
end

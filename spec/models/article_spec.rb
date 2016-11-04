require 'rails_helper'

describe Article do
  fixtures :articles, :users

  describe '#author' do
    context 'when article has no user' do
      let(:article) { articles(:culture) }

      it 'returns the default user' do
        expect(article.author.name).to eq(User::DEFAULT_NAME)
      end
    end

    context 'when article has user' do
      let(:article) { articles(:youse) }

      it 'returns the user' do
        expect(article.author.name).to eq('John Doe')
      end
    end
  end

  context 'duplicated urls' do
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

    before do
      allow(Page).to receive(:read).and_return(page_content)
    end

    context 'when url is black listed' do
      it 'does not save the article' do
        expect { Article.build(user_id, URL::BLACK_LIST[0]) }.to change { Article.count }.by(0)
      end
    end

    context 'when url is already saved' do
      it 'does not save the article' do
        expect { Article.build(user_id, Article.last.url) }.to change { Article.count }.by(0)
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
  end
end

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
end

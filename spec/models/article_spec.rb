require 'rails_helper'

describe Article do
  fixtures :articles, :users

  describe '.author_name_for_article' do
    context 'when article has no user' do
      let(:article) { articles(:culture) }
      it 'returns the author name from the article' do
        expect(article.author).to eq('Fulano')
      end
    end

    context 'when article has author' do
      let(:article) { articles(:youse) }
      it 'returns the author name from the user' do
        article.author_name = 'Fake'
        expect(article.author).to eq('John Doe')
      end
    end
  end
end

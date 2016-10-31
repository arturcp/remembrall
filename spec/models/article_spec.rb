require 'rails_helper'

describe Article do
  fixtures :articles, :users

  describe '#author' do
    context 'when article has no user' do
      let(:article) { articles(:culture) }

      it 'returns the default user' do
        expect(article.author.name).to eq('Remembrall')
      end
    end

    context 'when article has user' do
      let(:article) { articles(:youse) }

      it 'returns the user' do
        expect(article.author.name).to eq('John Doe')
      end
    end
  end
end

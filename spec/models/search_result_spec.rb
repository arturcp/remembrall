require 'rails_helper'

describe SearchResult do
  fixtures :articles, :users

  describe '#articles' do
    context 'and the query is empty' do
      subject { SearchResult.new }

      it { expect(subject.articles.count).to eq(3) }
    end

    context 'and the query is provided' do
      subject { SearchResult.new(query: 'Roe') }

      it { expect(subject.articles.count).to eq(1) }
    end

    context 'when the query does not match the case' do
      subject { SearchResult.new(query: 'roe') }

      it { expect(subject.articles.count).to eq(1) }
    end
  end
end

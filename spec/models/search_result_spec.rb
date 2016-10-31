require 'rails_helper'

describe SearchResult do
  fixtures :articles, :users

  describe '#articles' do
    context 'when the search is by keyword' do
      let(:search_type) { SearchType::KEYWORD }

      context 'and the query is empty' do
        subject { SearchResult.new(search_type: search_type) }

        it { expect(subject.articles.count).to eq(0) }
      end

      context 'and the query is provided' do
        subject { SearchResult.new(search_type: search_type, query: 'seguro') }

        it { expect(subject.articles.count).to eq(1) }
      end

      context 'when the query does not match the case' do
        subject { SearchResult.new(search_type: search_type, query: 'Seguro') }

        it { expect(subject.articles.count).to eq(1) }
      end
    end

    context 'when the search is by author name' do
      let(:search_type) { SearchType::AUTHOR }

      context 'and the query is empty' do
        subject { SearchResult.new(search_type: search_type) }

        it { expect(subject.articles.count).to eq(2) }
      end

      context 'and the query is provided' do
        subject { SearchResult.new(search_type: search_type, query: 'Roe') }

        it { expect(subject.articles.count).to eq(1) }
      end

      context 'when the query does not match the case' do
        subject { SearchResult.new(search_type: search_type, query: 'roe') }

        it { expect(subject.articles.count).to eq(1) }
      end
    end

    xcontext 'when the search is by tag' do
      subject { SearchResult.new(search_type: SearchType::TAG, query: 'Awesome') }

      it { expect(subject.articles.count).to eq(2) }
    end
  end
end

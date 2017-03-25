require 'rails_helper'

describe SearchResult do
  let!(:youse) { create(:youse) }

  before do
    Article.delete_all

    create(:ebooks)
    create(:culture)
  end

  xdescribe '#articles' do
    context 'and the query is empty' do
      subject { SearchResult.new }

      it { expect(subject.articles.count).to eq(3) }
    end

    context 'and the query is provided' do
      before do
        collection = youse.collection
        channel_id = youse.channel_id

        user = User.create!(collection: collection, name: 'My precious')
        Article.create!(collection: collection, channel_id: channel_id, title: 'my article', user: user)
      end

      subject { SearchResult.new(query: 'precious') }

      it { expect(subject.articles.count).to eq(1) }
    end

    context 'when the query does not match the case' do
      subject { SearchResult.new(query: 'roe') }

      it { expect(subject.articles.count).to eq(2) }
    end
  end
end

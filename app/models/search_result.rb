# frozen_string_literal: true

class SearchResult
  PAGE_SIZE = 10

  def initialize(query: '', search_type: SearchType::KEYWORD)
    @query = query.downcase
    @search_type = search_type
  end

  def articles
    send("search_by_#{@search_type}", @query)
  end

  private

  def search_by_keyword(query)
    Article.with_query(query)
  end

  def search_by_author(query)
    Article
      .where("lower(author_name) like :name", name: "%#{@query}%")
      .order(created_at: :desc)
  end

  def search_by_tag(query)
    Article.tagged_with(query).order(created_at: :desc)
  end
end

module CardHelper
  def highlighted_text(text, query)
    return text unless text.present? && query.present?

    text
      .gsub(/#{query}/i, "<mark>#{query}</mark>")
      .html_safe
  end
end

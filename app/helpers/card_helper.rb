module CardHelper
  def highlighted_text(text, query)
    return text unless text.present? && query.present?

    text
      .gsub(/#{query}/i, "<span class='highlight'>#{query}</span>")
      .html_safe
  end
end

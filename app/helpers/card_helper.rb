module CardHelper
  def highlighted_text(text, query)
    text
      .gsub(/#{query}/i, "<span class='highlight'>#{query}</span>")
      .html_safe
  end
end

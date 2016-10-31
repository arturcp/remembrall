module CardHelper
  def highlighted_text(text, query)
    return '' unless text

    text
      .gsub(/#{query}/i, "<span class='highlight'>#{query}</span>")
      .html_safe
  end
end

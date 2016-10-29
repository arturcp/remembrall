module CardHelper
  def format_description(description, query)
    description
      .gsub("\n", '<br />')
      .gsub(/#{query}/i, "<span class='highlight'>#{query}</span>")
      .html_safe
  end
end

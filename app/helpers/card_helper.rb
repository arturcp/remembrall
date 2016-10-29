module CardHelper
  def format_description(description, word)
    description
      .gsub("\n", '<br />')
      .gsub(/#{word}/i, "<span class='highlight'>#{word}</span>")
      .html_safe
  end
end

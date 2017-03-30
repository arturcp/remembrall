#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", 'xmlns:atom' => 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.title 'Remebrall'
    xml.tag! 'atom:link', rel: 'self', type: 'application/rss+xml', href: feed_url(collection: @collection)
    xml.description 'Links shared on Slack'
    xml.link collection_url_for_feed(request.url)
    xml.language 'pt-BR'

    for article in @articles
      xml.item do
        xml.title article.title
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link article.url
        xml.guid article.url

        text = article.description

        image_tag = "<p><img src='#{article.image_url}' alt='#{article.title}' title='#{article.title}' /></p>"

        xml.description "#{image_tag}<p>#{article.description}</p>"
      end
    end
  end
end

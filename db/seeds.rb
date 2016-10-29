# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Article.delete_all
Article.create!(
  title: 'Youse: Seguro online tipo vc',
  description: 'Na Youse o seguro é tipo você. Em poucos minutos você monta seu seguro online, personalizado, do jeito que você precisa e que cabe no seu bolso.',
  url: 'http://www.youse.com.br',
  author_name: 'John Doe',
  image_url: 'https://www.youse.com.br/assets/facebook_share-ff8b91c1755f47f546daaef5d1de59042bd82d6b259e7d6fd48f3c76a1d46f7a.jpg'
)

Article.create!(
  title: 'Free Programming Ebooks',
  description: 'We have compiled the best insights from subject matter experts and industry insiders for you in one place, so you can dive deep into the latest of what’s happening in the world of software engineering, architecture, and open source.',
  url: 'http://www.oreilly.com/programming/free/',
  author_name: 'Jane Roe',
  image_url: 'http://cdn.oreillystatic.com/oreilly/images/oreilly-social-icon-200.png'
)

Article.create!(
  title: 'Culture Code: What Makes a Company Great?',
  description: 'How do you create the ideal workplace? Share the values, rules, principles and tactics your organization follows. Upload your presentation and tag it #CultureCode.',
  url: 'http://www.slideshare.net/tag/culturecode',
  author_name: 'Fulano',
  image_url: 'http://slideshare-wordpress-blog-pictures.s3.amazonaws.com/tag_og_culturecode.jpg'
)

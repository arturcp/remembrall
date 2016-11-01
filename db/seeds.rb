# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
john = User.create!(
  slack_id: 'AB34234',
  name: 'John Doe',
  avatar_url: 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/5f/5f687f807101010d7e30da7d6c47554e87d361ec.jpg'
)

jane = User.create!(
  slack_id: 'CD9999',
  name: 'Jane Roe',
  avatar_url: 'http://static.minilua.com/wp-content/uploads/2011/03/Maggie.jpg'
)

Article.delete_all
Article.create!(
  title: 'Youse: Seguro online tipo vc',
  description: 'Na Youse o seguro é tipo você. Em poucos minutos você monta seu seguro online, personalizado, do jeito que você precisa e que cabe no seu bolso.',
  url: 'http://www.youse.com.br',
  image_url: 'https://www.youse.com.br/assets/facebook_share-ff8b91c1755f47f546daaef5d1de59042bd82d6b259e7d6fd48f3c76a1d46f7a.jpg',
  user: john
)

Article.create!(
  title: 'Free Programming Ebooks',
  description: 'We have compiled the best insights from subject matter experts and industry insiders for you in one place, so you can dive deep into the latest of what’s happening in the world of software engineering, architecture, and open source.',
  url: 'http://www.oreilly.com/programming/free/',
  image_url: 'http://cdn.oreillystatic.com/oreilly/images/oreilly-social-icon-200.png',
  user: jane
)

Article.create!(
  title: 'Culture Code: What Makes a Company Great?',
  description: 'How do you create the ideal workplace? Share the values, rules, principles and tactics your organization follows. Upload your presentation and tag it #CultureCode.',
  url: 'http://www.slideshare.net/tag/culturecode',
  image_url: 'http://slideshare-wordpress-blog-pictures.s3.amazonaws.com/tag_og_culturecode.jpg',
  created_at: Date.parse('2017-01-01')
)

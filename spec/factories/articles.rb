FactoryGirl.define do
  factory :youse, class: Article do
    title 'Youse: Seguro online tipo vc'
    description 'Na Youse o seguro é tipo você. Em poucos minutos você monta seu seguro online, personalizado, do jeito que você precisa e que cabe no seu bolso.'
    url 'http://www.youse.com.br'

    association :user, factory: :john
  end

  factory :ebooks, class: Article do
    title 'Free Programming Ebooks'
    description 'We have compiled the best insights from subject matter experts and industry insiders for you in one place, so you can dive deep into the latest of what’s happening in the world of software engineering, architecture, and open source.'
    url 'http://www.oreilly.com/programming/free/'

    association :user, factory: :jane
  end

  factory :culture, class: Article do
    title 'Culture Code: What Makes a Company Great?'
    description 'How do you create the ideal workplace? Share the values, rules, principles and tactics your organization follows. Upload your presentation and tag it #CultureCode.'
    url 'http://www.slideshare.net/tag/culturecode'
  end
end

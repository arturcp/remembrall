FactoryGirl.define do
  factory :john, class: User do
    slack_id 'AB34234'
    name 'John Doe'
    avatar_url 'http://avatars.com/john'

    association :collection, factory: :main_collection
  end

  factory :jane, class: User do
    slack_id 'CD9999'
    name 'Jane Roe'
    avatar_url 'http://avatars.com/jane'

    association :collection, factory: :main_collection
  end
end

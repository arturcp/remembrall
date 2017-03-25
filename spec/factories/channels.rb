FactoryGirl.define do
  factory :channel do
    name 'my channel'
    slack_channel_id 'XXXXXXX'
    association :collection, factory: :main_collection
  end
end

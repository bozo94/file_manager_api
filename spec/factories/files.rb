FactoryBot.define do 
  factory :api_file do 
    name { Faker::Lorem.word }
    tag_list { ["tag1", "tag2", "tag3"].sample(2).join(',') + ",tag4,tag5" }
  end
end
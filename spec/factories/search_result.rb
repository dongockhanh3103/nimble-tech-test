FactoryBot.define do
  factory :search_result do
    user

    sequence :keyword do |n|
      "keyword_#{n}"
    end
  end
end
 
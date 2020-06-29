FactoryBot.define do
  factory :user_report do
    user

    report_type { 'dummy' }
  end
end
 
FactoryBot.define do
  factory :course do
    name { 'Ruby' }
    description { 'Um curso de Ruby' }
    sequence(:code) { |n| "RUBYBASIC#{n}" }
    price { rand(10..100) }
    enrollment_deadline { 1.month.from_now }
    instructor
  end
end

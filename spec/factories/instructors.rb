FactoryBot.define do
  factory :instructor do
    name { 'Gustavo Guanabara' }
    sequence(:email) { |n| "guanabara#{n}@codeplay.com.br" }
  end
end

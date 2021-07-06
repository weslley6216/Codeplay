FactoryBot.define do
  factory :lesson do
    name { 'Primeira aula' }
    content { 'Tipos primitivos' }
    duration { rand(1..20) }
    course
  end
end

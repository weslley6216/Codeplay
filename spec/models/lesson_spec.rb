require 'rails_helper'

describe Lesson do
  context 'validation' do
    it 'attributes cannot be blank' do
      lesson = Lesson.new

      lesson.valid?

      expect(lesson.errors[:name]).to include('não pode ficar em branco')
    end

    it 'code must be uniq' do
      instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                      email: 'guanabara@codeplay.com')
      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                              code: 'RUBYBASIC', price: 10,
                              enrollment_deadline: '22/12/2033', instructor: instructor)
      Lesson.create!(name: 'Primeira aula', content: 'Tipos Primitivos', course: course)
      
      lesson = Lesson.new(name: 'Primeira aula')

      lesson.valid?

      expect(lesson.errors[:name]).to include('já está em uso')
    end
  end
end

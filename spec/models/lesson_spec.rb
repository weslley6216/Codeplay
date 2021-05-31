require 'rails_helper'

describe Lesson do
  
  it { should belong_to(:course) }
  
  context 'validation' do
    it 'attributes cannot be blank' do
      lesson = Lesson.new

      lesson.valid?

      expect(lesson.errors[:name]).to include('não pode ficar em branco')
    end

    it 'name must be uniq' do
      instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                      email: 'guanabara@codeplay.com')
      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                              code: 'RUBYBASIC', price: 10,
                              enrollment_deadline: '22/12/2033', instructor: instructor)
      Lesson.create!(name: 'Primeira aula', content: 'Tipos Primitivos', duration: 20, course: course)
      
      lesson = Lesson.new(name: 'Primeira aula')

      lesson.valid?

      expect(lesson.errors[:name]).to include('já está em uso')
    end

    it 'duration must be greater than zero' do
      instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                      email: 'guanabara@codeplay.com')
      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                              code: 'RUBYBASIC', price: 10,
                              enrollment_deadline: '22/12/2033', instructor: instructor)
      Lesson.create!(name: 'Primeira aula', content: 'Tipos Primitivos', duration: 20, course: course)

      lesson = Lesson.new(duration: 0)

      lesson.valid?

      expect(lesson.errors[:duration]).to include('deve ser maior que 0')

      end
    end
  end

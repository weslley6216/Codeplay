require 'rails_helper'

describe 'Admin updates lessons' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)
    lesson = Lesson.create!(name: 'Primeira aula', content: 'Tipos primitivos', course: course)

    visit course_lessons_path(lesson)
    click_on 'Editar'

    fill_in 'Nome', with: 'Segunda aula'
    fill_in 'Conteúdo', with: 'Coleções'
    
    click_on 'Atualizar'

    expect(page).to have_text('Segunda aula')
    expect(page).to have_text('Coleções')
    expect(page).to have_text('Aula atualizada com sucesso')

  end
end
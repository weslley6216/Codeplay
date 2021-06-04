require 'rails_helper'

describe 'Admin registers lessons in a course' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)
    login_admin
    visit admin_courses_path
    click_on 'Ruby'
    click_on 'Cadastrar Nova Aula'

    fill_in 'Nome', with: 'Primeira aula'
    fill_in 'Conteúdo', with: 'Tipos primitivos'
    fill_in 'Duração', with: 20
    click_on 'Cadastrar Aula'
    
    expect(current_path).to eq(admin_course_path(course))
    expect(page).to have_content('Primeira aula')
    expect(page).to have_content('20 minutos')
    expect(page).to have_link('Voltar', href: admin_courses_path)
    expect(page).to have_content('Aula cadastrada com sucesso!')
  end

  it 'and attributes cannot be blank' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)
    login_admin
    visit admin_course_path(course)
    click_on 'Cadastrar Nova Aula'

    fill_in 'Nome', with: ''
    fill_in 'Conteúdo', with: ''
    fill_in 'Duração', with: ''
    click_on 'Cadastrar Aula'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  it 'and code must be unique' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)
    Lesson.create!(name: 'Primeira aula', content: 'Tipos primitivos', duration: 20, course: course)

    login_admin
    visit admin_course_path(course)
    click_on 'Cadastrar Nova Aula'

    fill_in 'Nome', with: 'Primeira aula'
    fill_in 'Conteúdo', with: 'Coleções'
    fill_in 'Duração', with: '20 minutos'
    click_on 'Cadastrar Aula'

    expect(page).to have_content('já está em uso')
  end
end
require 'rails_helper'

describe 'logged in user' do
  it 'visit home page' do
    user = User.create!(email: 'janedoe@codeplay.com', password: '123456')

    login_as user, scope: :user
    visit root_path

    expect(page).to have_content(user.email)
    expect(page).to have_link('Cursos')
    expect(page).to have_link('Meus Cursos')
    expect(page).to have_link('Sair')
  end

  it 'courses with enrollment still avaiable' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com')
    
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: 1.month.from_now, instructor: instructor)

    Course.create!(name: 'HTML', description: 'Um curso de HTML',
                   code: 'HTMLBASIC', price: 15,
                   enrollment_deadline: 2.day.ago, instructor: instructor)

    login_user
    visit root_path
    
    expect(page).to have_text('Ruby')
    expect(page).to have_text('Um curso de Ruby')
    expect(page).to have_text('R$ 10,00')
    expect(page).not_to have_text('HTML')
    expect(page).not_to have_text('Um curso de HTML')
    expect(page).not_to have_text('R$ 15,00')
  end

  it 'and view enrollment link' do
    user = User.create!(email: 'janedoe@codeplay.com', password: '123456')
    instructor = Instructor.create!(name: 'Gustavo Guanabara', 
                                    email: 'guanabara@codeplay.com')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: 1.month.from_now, instructor: instructor)

    login_as user, scope: :user
    visit user_courses_path
    click_on 'Ruby'

    expect(page).to have_link 'Comprar'
  end

  xit 'and does not view enrollment if deadline is over' do
    # curso com data limite ultrapassada mas com usuario logado não deve exibir o link
  end

  it 'and buy a course' do 
    instructor = Instructor.create!(name: 'Gustavo Guanabara', 
                                    email: 'guanabara@codeplay.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: 1.month.from_now, instructor: instructor)
    
    other_course = Course.create!(name: 'Elixir', description: 'Um curso de Elixir',
                                  code: 'ELIXIRBASIC', price: 20,
                                  enrollment_deadline: 1.month.from_now, instructor: instructor)

    login_user
    visit user_course_path(course)
    click_on 'Comprar'
    
    expect(page).to have_content('Curso comprado com sucesso')
    expect(current_path).to eq(my_enrolls_user_courses_path)
    expect(page).to have_content('Ruby')
    expect(page).to have_content('R$ 10,00')
    expect(page).to_not have_content('Elixir')
    expect(page).to_not have_content('R$ 20,00')

  end

  it 'and cannot buy a course twice' do
    user = User.create!(email: 'janedoe@codeplay', password: '123456')
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com.br')

    available_course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                      code: 'RUBYBASIC', price: 10,
                                      enrollment_deadline: 1.month.from_now, instructor: instructor)
    Lesson.create!(name: 'Primeira aula', content: 'Tipos primitivos', duration: 20, course: available_course)
    Enrollment.create!(user: user, course: available_course)

    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'

    expect(page).to_not have_link 'Comprar'
    expect(page).to have_link 'Primeira aula'
  end
end
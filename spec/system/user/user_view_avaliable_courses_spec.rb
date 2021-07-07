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
    create(:course, name: 'Ruby', description: 'Um curso de Ruby',
                    code: 'RUBYBASIC', price: 10,
                    enrollment_deadline: 1.month.from_now)

    create(:course, name: 'HTML', description: 'Um curso de HTML', price: 15, enrollment_deadline: 2.day.ago)

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
    user = create(:user)
    create(:course, name: 'Ruby')

    login_as user, scope: :user
    visit user_courses_path
    click_on 'Ruby'

    expect(page).to have_link 'Comprar'
  end

  xit 'and does not view enrollment if deadline is over' do
    # curso com data limite ultrapassada mas com usuario logado não deve exibir o link
  end

  it 'and buy a course' do 
    course = create(:course, name: 'Ruby', price: 10)
    create(:course, name: 'Elixir', price: 20)

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
    user = create(:user)
    available_course = create(:course, name: 'Ruby')
    create(:lesson, name: 'Primeira aula', course: available_course)
    Enrollment.create!(user: user, course: available_course)

    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'

    expect(page).to_not have_link 'Comprar'
    expect(page).to have_link 'Primeira aula'
  end
end

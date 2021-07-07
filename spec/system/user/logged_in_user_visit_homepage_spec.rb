require 'rails_helper'

describe 'logged in user ' do
  it 'visit home page' do
    user = create(:user)

    login_as user, scope: :user
    visit root_path

    expect(page).to have_content(user.email)
    expect(page).to have_link('Cursos')
    expect(page).to have_link('Meus Cursos')
    expect(page).to have_link('Sair')
  end

  it 'visit courses available' do
    create(:course, name: 'Ruby', description: 'Um curso de Ruby', price: 10)

    login_user
    visit root_path

    expect(page).to have_content('Ruby')
    expect(page).to have_content('Um curso de Ruby')
    expect(page).to have_content('R$ 10,00')
  end

  it 'and click on an available course' do
    instructor = create(:instructor, name: 'Gustavo Guanabara')
    course = create(:course, name: 'Ruby', description: 'Um curso de Ruby',
                             code: 'RUBYBASIC', instructor: instructor)

    login_user
    visit user_course_path(course)

    expect(page).to have_content('Ruby')
    expect(page).to have_content('Um curso de Ruby')
    expect(page).to have_content('RUBYBASIC')
    expect(page).to have_content('Gustavo Guanabara')
    expect(page).to have_link('Comprar')

  end
end
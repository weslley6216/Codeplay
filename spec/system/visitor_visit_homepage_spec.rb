require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'CodePlay')
    expect(page).to have_css('p', text: 'Boas vindas ao sistema de gestão de '\
                                         'cursos e aulas')
    expect(page).to have_content('Cadastre-se')
    expect(page).to have_content('Entrar')
    expect(page).to have_content('Cursos Disponíveis')
  end

  it 'and click on an available course' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)

    login_user
    visit course_path(course)

    expect(page).to have_content('Ruby')
    expect(page).to have_content('Um curso de Ruby')
    expect(page).to have_content('RUBYBASIC')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('Gustavo Guanabara')
    expect(page).to have_text('Faça login para comprar este curso')
    expect(page).to have_link('Voltar', href: root_path)

  end
end
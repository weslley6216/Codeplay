require 'rails_helper'

describe 'Admin view courses' do
  it 'successfully' do
    create(:course, name: 'Ruby', description: 'Um curso de Ruby', price: 10)
    create(:course, name: 'Ruby on Rails', description: 'Um curso de Ruby on Rails', price: 20)

    login_admin
    visit root_path
    click_on 'Cursos'

    expect(page).to have_content('Ruby')
    expect(page).to have_content('Um curso de Ruby')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('R$ 20,00')
  end

  it 'and view details' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)
    Course.create!(name: 'Ruby on Rails',
                   description: 'Um curso de Ruby on Rails',
                   code: 'RUBYONRAILS', price: 20,
                   enrollment_deadline: '20/12/2033', instructor: instructor)

    login_admin
    visit admin_courses_path
    click_on 'Ruby on Rails'

    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 20,00')
    expect(page).to have_content('20/12/2033')
  end

  it 'and no course is available' do
    login_admin
    visit admin_courses_path

    expect(page).to have_content('Nenhum curso disponível')
  end

  it 'and return to home page' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033',
                   instructor: instructor)

    login_admin
    visit admin_courses_path
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'and return to promotions page' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)

    login_admin
    visit admin_courses_path
    click_on 'Ruby'
    click_on 'Voltar'

    expect(current_path).to eq admin_courses_path
  end
end

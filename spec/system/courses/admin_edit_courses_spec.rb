require 'rails_helper'

describe 'Admin updates courses' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)

    visit course_path(course)
    click_on 'Editar'

    fill_in 'Nome', with: 'Ruby on Rails'
    fill_in 'Descrição', with: 'Um curso de RoR'
    fill_in 'Código', with: 'RUBYONRAILS'
    fill_in 'Preço', with: '50'
    fill_in 'Data limite de matrícula', with: Date.current.strftime('%d/%m/%Y')
    select 'Gustavo Guanabara', from: 'Professor'
    click_on 'Atualizar'

    expect(page).to have_text('Ruby on Rails')
    expect(page).to have_text('Um curso de RoR')
    expect(page).to have_text('RUBYONRAILS')
    expect(page).to have_text('R$ 50,00')
    expect(page).to have_text(Date.current.strftime('%d/%m/%Y'))
    expect(page).to have_text('Gustavo Guanabara')
    expect(page).to have_text('Curso atualizado com sucesso!')

  end

  it 'and attributes cannot be blank' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)

    visit course_path(course)
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    fill_in 'Preço', with: ''
    fill_in 'Data limite de matrícula', with: ''
    select 'Gustavo Guanabara', from: 'Professor'
    click_on 'Atualizar'

    expect(page).to have_content('não pode ficar em branco', count: 3)

  end
end
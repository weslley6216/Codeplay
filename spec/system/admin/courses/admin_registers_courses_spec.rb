require 'rails_helper'

describe 'Admin registers courses' do
  it 'successfully' do
    instructor = create(:instructor)

    login_admin
    visit admin_courses_path
    click_on 'Criar Curso'

    fill_in 'Nome', with: 'Ruby on Rails'
    fill_in 'Descrição', with: 'Um curso de Ruby on Rails'
    fill_in 'Código', with: 'RUBYONRAILS'
    fill_in 'Preço', with: '30'
    fill_in 'Data limite de matrícula', with: '22/12/2033'
    select "#{instructor.name} - #{instructor.email}", from: 'Professor'
    click_on 'Cadastrar Curso'

    expect(current_path).to eq(admin_course_path(Course.last))
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_link('Voltar')
    expect(page).to have_content('Curso cadastrado com sucesso')
  end

  it 'and attributes cannot be blank' do
    create(:course)

    login_admin
    visit admin_courses_path
    click_on 'Criar Curso'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    fill_in 'Preço', with: ''
    fill_in 'Data limite de matrícula', with: ''
    #attach_file 'Banner', Rails.root.join('spec/fixtures/course.jpg')
    click_on 'Cadastrar Curso'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  it 'and code must be unique' do
    create(:course, code: 'RUBYBASIC')

    login_admin
    visit admin_courses_path
    click_on 'Criar Curso'
    fill_in 'Código', with: 'RUBYBASIC'
    click_on 'Cadastrar Curso'

    expect(page).to have_content('já está em uso')
  end
end

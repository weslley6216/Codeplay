require 'rails_helper'

describe 'Admin registers instructors' do
  it 'from index page' do
    visit root_path
    click_on 'Professores'

    expect(page).to have_link('Registrar um Professor',
                              href: new_instructor_path)
  end

  it 'successfully' do
    visit root_path
    click_on 'Professores'
    click_on 'Registrar um Professor'

    fill_in 'Nome', with: 'Gustavo Guanabara'
    fill_in 'Email', with: 'guanabara@codeplay.com'
    fill_in 'Descrição', with: 'Professor por vocação'
    click_on 'Cadastrar Professor'

    expect(current_path).to eq(instructor_path(Instructor.last))
    expect(page).to have_content('Gustavo Guanabara')
    expect(page).to have_content('guanabara@codeplay.com')
    expect(page).to have_content('Professor por vocação')
  end

  it 'and attributes cannot be blank' do
    Instructor.create!(name: 'Gustavo Guanabara', email: 'guanabara@codeplay.com',
                       bio: 'Professor por vocação')
    visit root_path
    click_on 'Professores'
    click_on 'Registrar um Professor'
    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Cadastrar Professor'

  expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and email must be unique' do
    Instructor.create!(name: 'Gustavo Guanabara', email: 'guanabara@codeplay.com',
                       bio: 'Professor por vocação')

    visit root_path
    click_on 'Professores'
    click_on 'Registrar um Professor'
    fill_in 'Email', with: 'guanabara@codeplay.com'
    click_on 'Cadastrar Professor'

    expect(page).to have_content('O email informado já está em uso')
  end
end
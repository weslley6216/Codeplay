require 'rails_helper'

describe 'Admin registers instructors' do
  it 'successfully' do
    login_admin
    visit root_path
    click_on 'Professores'
    click_on 'Cadastrar Professor'

    fill_in 'Nome', with: 'Gustavo Guanabara'
    fill_in 'Email', with: 'guanabara@codeplay.com'
    fill_in 'Descrição', with: 'Professor por vocação'
    attach_file 'Foto de Perfil', Rails.root.join('spec/fixtures/foto_perfil.jpeg')
    click_on 'Cadastrar Professor'

    expect(current_path).to eq(admin_instructor_path(Instructor.last))
    expect(page).to have_content('Gustavo Guanabara')
    expect(page).to have_content('guanabara@codeplay.com')
    expect(page).to have_content('Professor por vocação')
    expect(page).to have_css('img[src*="foto_perfil.jpeg"]')
    expect(page).to have_content('Professor Cadastrado com Sucesso')
  end

  it 'and attributes cannot be blank' do
    create(:instructor)

    login_admin
    visit admin_instructors_path

    click_on 'Cadastrar Professor'
    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Cadastrar Professor'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and email must be unique' do
    create(:instructor, email: 'guanabara@codeplay.com')

    login_admin
    visit admin_instructors_path
    click_on 'Cadastrar Professor'
    fill_in 'Email', with: 'guanabara@codeplay.com'
    click_on 'Cadastrar Professor'

    expect(page).to have_content('não pode ficar em branco')
  end
end

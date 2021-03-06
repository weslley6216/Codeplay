require 'rails_helper'

describe 'Admin updates instructor registration' do
  it 'successfully' do
    instructor = create(:instructor, name: 'GustavoGuanabara')
    instructor.profile_picture.attach(io: File.open('spec/fixtures/foto_perfil.jpeg'),
                                      filename: 'foto_perfil.jpeg')
    login_admin
    visit root_path
    click_on 'Professores'
    click_on 'GustavoGuanabara'
    click_on 'Editar'

    fill_in 'Nome', with: 'Gustavo Guanabara'
    fill_in 'Email', with: 'guanabara@codeplay.com'
    fill_in 'Descrição', with: 'Professor por vocação'
    attach_file 'Foto de Perfil', Rails.root.join('spec/fixtures/foto_perfil.jpeg')
    click_on 'Atualizar'

    expect(page).to have_content('Gustavo Guanabara')
    expect(page).to have_content('guanabara@codeplay.com')
    expect(page).to have_content('Professor por vocação')
    expect(page).to have_css('img[src*="foto_perfil.jpeg"]')
  end

  it 'and attributes cannot be blank' do
    instructor = create(:instructor)
    instructor.profile_picture.attach(io: File.open('spec/fixtures/foto_perfil.jpeg'),
                                      filename: 'foto_perfil.jpeg')

    login_admin
    visit admin_instructors_path
    click_on 'Cadastrar Professor'
    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    fill_in 'Descrição', with: ''
    attach_file 'Foto de Perfil', Rails.root.join('spec/fixtures/foto_perfil.jpeg')
    click_on 'Cadastrar Professor'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and email must be unique' do
    instructor = create(:instructor, email: 'guanabara@codeplay.com')
    instructor.profile_picture.attach(io: File.open('spec/fixtures/foto_perfil.jpeg'),
                                      filename: 'foto_perfil.jpeg')

    login_admin
    visit admin_instructors_path
    click_on 'Cadastrar Professor'
    fill_in 'Email', with: 'guanabara@codeplay.com'
    attach_file 'Foto de Perfil', Rails.root.join('spec/fixtures/foto_perfil.jpeg')
    click_on 'Cadastrar Professor'

    expect(page).to have_content('já está em uso')
  end
end

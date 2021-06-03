require 'rails_helper'

describe 'Admin view instructors' do
  it 'successfully' do
    Instructor.create!(name: 'Gustavo Guanabara', email: 'guanabara@codeplay.com',
                       bio: 'Professor por vocação')
    Instructor.create!(name: 'Jackson Pires', email: 'jackson@codeplay.com',
                       bio: 'Engenheiro de Software')

    visit root_path
    click_on 'Professores'


    expect(page).to have_content('Gustavo Guanabara')
    expect(page).to have_content('Jackson Pires')
  end

  it 'and view details' do
    Instructor.create!(name: 'Gustavo Guanabara', email: 'guanabara@codeplay.com',
                       bio: 'Professor por vocação')
    Instructor.create!(name: 'Jackson Pires', email: 'jackson@codeplay.com',
                       bio: 'Engenheiro de Software')
    visit root_path
    click_on 'Professores'
    click_on 'Gustavo Guanabara'

    expect(page).to have_content('Gustavo Guanabara')
    expect(page).to have_content('guanabara@codeplay.com')
    expect(page).to have_content('Professor por vocação')
    # expect(page).to have_content('profile_picture')
  end

  it 'and no instructor is available' do
    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Nenhum professor cadastrado!')
  end

  it 'and return to home page' do
    Instructor.create!(name: 'Gustavo Guanabara', email: 'guanabara@codeplay.com',
                       bio: 'Professor por vocação')

    visit root_path
    click_on 'Professores'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'and return to instructors list page' do
    Instructor.create!(name: 'Gustavo Guanabara', email: 'guanabara@codeplay.com',
                       bio: 'Professor por vocação')

    visit root_path
    click_on 'Professores'
    click_on 'Gustavo Guanabara'
    click_on 'Voltar'

    expect(current_path).to eq instructors_path
  end
end
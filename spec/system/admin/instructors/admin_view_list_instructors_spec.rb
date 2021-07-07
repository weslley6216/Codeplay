require 'rails_helper'

describe 'Admin view instructors' do
  it 'successfully' do
    create(:instructor, name: 'Gustavo Guanabara', email: 'guanabara@codeplay.com',
                        bio: 'Professor por vocação')
    create(:instructor, name: 'Jackson Pires', email: 'jackson@codeplay.com',
                        bio: 'Engenheiro de Software')
    login_admin
    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Gustavo Guanabara')
    expect(page).to have_content('Jackson Pires')
  end

  it 'and view details' do
    create(:instructor, name: 'Gustavo Guanabara', email: 'guanabara@codeplay.com',
                        bio: 'Professor por vocação')

    create(:instructor, name: 'Jackson Pires', email: 'jackson@codeplay.com',
                        bio: 'Engenheiro de Software')

    login_admin
    visit admin_instructors_path
    click_on 'Gustavo Guanabara'

    expect(page).to have_content('Gustavo Guanabara')
    expect(page).to have_content('guanabara@codeplay.com')
    expect(page).to have_content('Professor por vocação')
    expect(page).to_not have_content('Jackson Pires')
    expect(page).to_not have_content('jackson@codeplay.com')
    expect(page).to_not have_content('Engenheiro de Software')
  end

  it 'and no instructor is available' do
    login_admin
    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Nenhum professor cadastrado!')
  end

  it 'and return to home page' do
    create(:instructor, name: 'Gustavo Guanabara', email: 'guanabara@codeplay.com',
                        bio: 'Professor por vocação')
    login_admin
    visit root_path
    click_on 'Professores'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'and return to instructors list page' do
    instructor = create(:instructor, name: 'Gustavo Guanabara', email: 'guanabara@codeplay.com',
                                     bio: 'Professor por vocação')
    login_admin
    visit admin_instructor_path(instructor)
    click_on 'Voltar'

    expect(current_path).to eq admin_instructors_path
  end
end

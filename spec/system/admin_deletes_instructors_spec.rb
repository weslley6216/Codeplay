require 'rails_helper'

describe 'admin deletes instructors' do
  it 'successfully' do
    Instructor.create!(name: 'Gustavo Guanabara', email: 'guanabara@codeplay.com',
                       bio: 'Professor por vocação')
    visit root_path
    click_on 'Professores'
    click_on 'Gustavo Guanabara'
    click_on 'Apagar'
    
    expect(current_path).to eq(instructors_path)
    expect(page).to have_content('Professor removido com sucesso!')
    expect(Instructor.count).to eq(0)
  end
end
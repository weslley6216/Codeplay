require 'rails_helper'

describe 'admin deletes instructors' do
  it 'successfully' do
    Instructor.create!(name: 'GustavoGuanabara', email: 'guanabara@codeplay.com',
                       bio: 'Professor por vocação')
    visit root_path
    click_on 'Professores'
    click_on 'GustavoGuanabara'
    click_on 'Apagar'
    
    expect(current_path).to eq(instructors_path)
    expect(page).to have_content('Professor removido com sucesso!')
  end
end
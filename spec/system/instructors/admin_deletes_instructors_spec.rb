require 'rails_helper'

describe 'admin deletes instructors' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara', email: 'guanabara@codeplay.com',
                                    bio: 'Professor por vocação')
    instructor.profile_picture.attach(io: File.open('spec/fixtures/foto_perfil.jpeg'),
                                      filename: 'foto_perfil.jpeg')
    visit root_path
    click_on 'Professores'
    click_on 'Gustavo Guanabara'
   
    expect { click_link 'Apagar' }.to change { Instructor.count }.by(-1)
    expect(page).to have_content('Professor removido com sucesso!')
    expect(current_path).to eq(instructors_path)
      
  end
end
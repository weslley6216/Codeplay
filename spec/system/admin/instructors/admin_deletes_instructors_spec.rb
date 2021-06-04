require 'rails_helper'

describe 'admin deletes instructors' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara', email: 'guanabara@codeplay.com',
                                    bio: 'Professor por vocação')
    instructor.profile_picture.attach(io: File.open('spec/fixtures/foto_perfil.jpeg'),
                                      filename: 'foto_perfil.jpeg')
    login_admin
    visit root_path
    click_on 'Professores'
    click_on 'Gustavo Guanabara'
   
    expect { click_link 'Apagar' }.to change { Instructor.count }.by(-1)
    expect(page).to have_content('Professor removido com sucesso!')
    expect(current_path).to eq(admin_instructors_path)
  end

  it "can't delete an instructor with courses on the platform" do
    instructor = Instructor.create!(name: 'Gustavo Guanabara', email: 'guanabara@codeplay.com',
                                    bio: 'Professor por vocação')
    instructor.profile_picture.attach(io: File.open('spec/fixtures/foto_perfil.jpeg'),
                                      filename: 'foto_perfil.jpeg')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)
                   
    login_admin
    visit admin_instructor_path(instructor)
    click_on 'Apagar'

    expect(page).to have_content('Erro! Professor possui cursos ativos na plataforma!')
    expect(current_path).to eq(admin_instructor_path(instructor))
  end
end
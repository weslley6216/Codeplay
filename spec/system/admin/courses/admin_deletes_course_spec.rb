require 'rails_helper'

describe 'Admin deletes course' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)
  
    login_admin
    visit admin_course_path(course)

    expect { click_link 'Apagar' }.to change { Course.count }.by(-1)
    expect(page).to have_content('Curso removido com sucesso')
    expect(current_path).to eq(admin_courses_path)

  end
end
require 'rails_helper'

describe 'Admin deletes course' do
  it 'successfully' do
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033')
  
    visit course_path(course)

    expect { click_link 'Apagar' }.to change { Course.count }.by(-1)
    expect(page).to have_content('Curso removido com sucesso')
    expect(current_path).to eq(courses_path)

  end
end
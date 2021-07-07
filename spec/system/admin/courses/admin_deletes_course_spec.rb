require 'rails_helper'

describe 'Admin deletes course' do
  it 'successfully' do

    course = create(:course)

    login_admin
    visit admin_course_path(course)

    expect { click_link 'Apagar' }.to change { Course.count }.by(-1)
    expect(page).to have_content('Curso removido com sucesso')
    expect(current_path).to eq(admin_courses_path)

  end
end

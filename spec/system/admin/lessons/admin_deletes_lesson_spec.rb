require 'rails_helper'

describe 'Admin deletes lesson' do
  it 'successfully' do
    course = create(:course)
    lesson = create(:lesson, course: course)

    login_admin
    visit admin_course_path(lesson)

    within 'div#lessons' do
      expect { click_link 'Apagar' }.to change { course.lessons.count }.by(-1)
    end
    expect(page).to have_content('Aula removida com sucesso!')
    expect(current_path).to eq(admin_course_path(course))
  end
end

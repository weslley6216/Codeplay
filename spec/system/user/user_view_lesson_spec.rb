require 'rails_helper'

describe 'User view lesson' do
  xit 'successfully'

  it 'without enrollment cannot view lesson link' do
    course = create(:course)
    create(:lesson, name: 'Classes e Objetos', course: course, duration: 20,
                    content: 'Uma aula sobre Ruby')

    login_user
    visit user_courses_path
    click_on 'Ruby'

    expect(page).to_not have_link 'Classes e Objetos'
    expect(page).to have_content 'Classes e Objetos'
  end

  it 'without login cannot view lesson' do
    course = create(:course)
    lesson = create(:lesson)

    visit user_course_lesson_path(course, lesson)

    expect(current_path).to eq(new_user_session_path)
  end

  it 'without enrollment cannot view lesson' do
    course = create(:course)
    lesson = create(:lesson, course: course)

    login_user
    visit user_course_lesson_path(course, lesson)

    expect(current_path).to eq(user_course_path(course))
    expect(page).to have_link 'Comprar'
  end
end

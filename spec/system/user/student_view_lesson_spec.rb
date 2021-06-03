require 'rails_helper'

describe 'Student view lesson' do
  xit 'successfully' do
  end

  it 'without enrollment cannot view lesson link' do
    user = User.create!(email: 'jane@test.com.br', password: '123456')
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'janedoe@codeplay.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: 1.month.from_now, instructor: instructor)
    Lesson.create!(name: 'Classes e Objetos', course: course, duration: 20,
                   content: 'Uma aula sobre Ruby')

    login_as user, scope: :user
    visit admin_courses_path
    click_on 'Ruby'

    expect(page).to_not have_link 'Classes e Objetos'
    expect(page).to have_content 'Classes e Objetos'
  end

  it 'without login cannot view lesson' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com.br')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: 1.month.from_now, instructor: instructor)
    lesson = Lesson.create!(name: 'Classes e Objetos', course: course, duration: 20,
                            content: 'Uma aula sobre Ruby')

    visit admin_course_lesson_path(course, lesson)

    expect(current_path).to eq(new_user_session_path)
  end

  it 'without enrollment cannot view lesson' do
    user = User.create!(email: 'janedoe@codeplay.com', password: '123456')
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com.br')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: 1.month.from_now, instructor: instructor)
    lesson = Lesson.create!(name: 'Classes e Objetos', course: course, duration: 20,
                            content: 'Uma aula sobre Ruby')

    login_as user, scope: :user
    visit admin_course_lesson_path(course, lesson)

    expect(current_path).to eq(admin_course_path(course))
    expect(page).to have_link 'Comprar'
  end
end
require 'rails_helper'

describe 'student view courses on homepage' do
  it 'courses with enrollment still avaiable' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com')
    
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: 1.month.from_now, instructor: instructor)

    Course.create!(name: 'HTML', description: 'Um curso de HTML',
                   code: 'HTMLBASIC', price: 15,
                   enrollment_deadline: 2.day.ago, instructor: instructor)

    visit courses_path
    
    expect(page).to have_text('Ruby')
    expect(page).to have_text('Um curso de Ruby')
    expect(page).to have_text('R$ 10,00')
    expect(page).not_to have_text('HTML')
    expect(page).not_to have_text('Um curso de HTML')
    expect(page).not_to have_text('R$ 15,00')
  end

  it 'and view enrollment link' do
    user = User.create!(email: 'janedoe@codeplay.com', password: '123456')
    instructor = Instructor.create!(name: 'Gustavo Guanabara', 
                                    email: 'guanabara@codeplay.com')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: 1.month.from_now, instructor: instructor)

    login_as user, scope: :user
    visit courses_path
    click_on 'Ruby'

    expect(page).to have_link 'Comprar'
  end

  xit 'and does not view enrollment if deadline is over' do
    # curso com data limite ultrapassada mas com usuario logado não deve exibir o link
  end

  it 'must be signed in to enroll' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara', 
                                    email: 'guanabara@codeplay.com')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: 1.month.from_now, instructor: instructor)
    visit courses_path
    click_on 'Ruby'

    expect(page).not_to have_link 'Comprar'
    expect(page).to have_content 'Faça login para comprar este curso'
    expect(page).to have_link 'Entrar', href: new_user_session_path
  end

  it 'and buy a course' do 
    user = User.create!(email: 'janedoe@codeplay.com', password: '123456')
    instructor = Instructor.create!(name: 'Gustavo Guanabara', 
                                    email: 'guanabara@codeplay.com')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: 1.month.from_now, instructor: instructor)
    
    Course.create!(name: 'Elixir', description: 'Um curso de Elixir',
                   code: 'ELIXIRBASIC', price: 20,
                   enrollment_deadline: 1.month.from_now, instructor: instructor)

    login_as user, scope: :user
    visit courses_path
    click_on 'Ruby'
    click_on 'Comprar'

    expect(page).to have_content('Curso comprado com sucesso')
    expect(current_path).to eq(my_enrolls_courses_path)
    expect(page).to have_content('Ruby')
    expect(page).to_not have_content('Elixir')

  end
end
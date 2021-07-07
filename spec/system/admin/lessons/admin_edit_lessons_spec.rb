require 'rails_helper'

describe 'Admin updates lessons' do
  it 'successfully' do
    course = create(:course)
    create(:lesson, name: 'Primeira aula', content: 'Tipos primitivos', duration: 20, course: course)

    login_admin
    visit admin_course_path(course)
    within 'div#lessons' do
      click_on 'Editar'
    end

    fill_in 'Nome', with: 'Segunda aula'
    fill_in 'Conteúdo', with: 'Coleções'
    fill_in 'Duração', with: 1

    click_on 'Atualizar'

    expect(page).to have_text('Segunda aula')
    expect(page).to have_text('1 minuto')
    expect(page).to have_text('Aula atualizada com sucesso!')
    expect(current_path).to eq(admin_course_path(course))
  end
end

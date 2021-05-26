require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'CodePlay')
    expect(page).to have_css('p', text: 'Boas vindas ao sistema de gestão de '\
                                         'cursos e aulas')
  end
end
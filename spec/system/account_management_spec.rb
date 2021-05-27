require 'rails_helper'

describe 'Account managesentt' do
  context 'registration' do
    it 'with email and password' do
      visit root_path
      click_on 'Cadastre-se'
      fill_in 'Email', with: 'janedoe@codeplay.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_on 'Criar conta'

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('janedoe@codeplay.com')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Registre-se')
      expect(page).to have_link('Sair')
    end

    xit 'without valid field' do
    end

    xit 'password not match confirmation' do
    end

    xit 'with email not unique' do
    end
  end

  context 'sign in' do
    it 'with email and password' do
      User.create!(email: 'janedoe@codeplay.com', password: '123456')

      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: 'janedoe@codeplay.com'
      fill_in 'Senha', with: '123456'
      within 'form' do
        click_on 'Entrar'
      end

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('janedoe@codeplay.com')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Cadastre-se')
      expect(page).to_not have_link('Entrar')
      expect(page).to have_link('Sair')
    end

    xit 'without valid field' do
    end
  end

  context 'logout' do
    it 'successfully' do
      user = User.create!(email: 'janedoe@codeplay.com', password: '123456')

      login_as user, scope: :user
      visit root_path
      click_on 'Sair'

      expect(page).to have_text('Saiu com sucesso')
      expect(page).to_not have_text('janedoe@codeplay.com')
      expect(current_path).to eq(root_path)
      expect(page).to have_link('Cadastre-se')
      expect(page).to have_link('Entrar')
      expect(page).to_not have_link('Sair')
    end
  end
end

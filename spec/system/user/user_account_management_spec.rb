require 'rails_helper'

describe 'User account management' do
  context 'registration' do
    it 'with email and password' do
      visit root_path
      click_on 'Cadastre-se'

      fill_in 'Email', with: 'user@user.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_on 'Criar conta'

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('user@user.com')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Registre-se')
      expect(page).to have_link('Sair')
    end

    it 'without valid field' do
      visit new_user_registration_path
      click_on 'Cadastre-se'
      fill_in 'Email', with: ''
      fill_in 'Senha', with: ''
      fill_in 'Confirmação de Senha', with: ''
      click_on 'Criar conta'

      expect(page).to have_text('Cadastro de Usuário')
      expect(page).to have_text('não pode ficar em branco', count: 2)
    end

    it 'password not match confirmation' do
      visit new_user_registration_path
      click_on 'Cadastre-se'
      fill_in 'Email', with: 'user@user.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '654321'
      click_on 'Criar conta'

      expect(page).to have_text('não é igual a Senha')
    end

    it 'with email not unique' do
      create(:user, email: 'user@user.com')

      visit new_user_registration_path
      click_on 'Cadastre-se'
      fill_in 'Email', with: 'user@user.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_on 'Criar conta'

      expect(page).to have_text('já está em uso')
    end
  end

  context 'sign in' do
    it 'with email and password' do
      create(:user, email: 'user@user.com', password: '123456')

      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: 'user@user.com'
      fill_in 'Senha', with: '123456'
      within 'div#login' do
        click_on 'Entrar'
      end

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('user@user.com')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Cadastre-se')
      expect(page).to_not have_link('Entrar')
      expect(page).to have_link('Sair')
    end

    it 'without valid field' do
      create(:user)

      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: ''
      fill_in 'Senha', with: ''
      within 'div#login' do
        click_on 'Entrar'
      end

      expect(page).to have_text('Email ou senha inválida')
    end
  end

  context 'logout' do
    it 'successfully' do
      login_user
      visit root_path
      click_on 'Sair'

      expect(page).to have_text('Saiu com sucesso')
      expect(page).to_not have_text('user@user.com')
      expect(current_path).to eq(root_path)
      expect(page).to have_link('Cadastre-se')
      expect(page).to have_link('Entrar')
      expect(page).to_not have_link('Sair')
    end
  end

  context 'user forgot password' do
    it 'receive reset email successfully' do
      create(:user, email: 'user@user.com')

      visit root_path
      click_on 'Entrar'
      click_on 'Esqueceu sua senha?'
      fill_in 'Email', with: 'user@user.com'
      click_on 'Envie-me instruções de redefinição de senha'

      expect(current_path).to eq(new_user_session_path)
      expect(page).to have_text('você receberá um e-mail com instruções para a troca da sua senha')
    end

    it 'and change password' do
      user = create(:user)
      token = user.send_reset_password_instructions

      visit edit_user_password_path(reset_password_token: token)
      fill_in 'Nova Senha', with: '12345678'
      fill_in 'Confirmar Nova Senha', with: '12345678'
      click_on 'Mudar Minha Senha'
      expect(page).to have_content('Sua senha foi alterada com sucesso')
      expect(current_path).to eq(root_path)
    end
  end
end

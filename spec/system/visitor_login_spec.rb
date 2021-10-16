require 'rails_helper'

describe 'Visitor login' do
  context 'as an user' do
    it 'successfully' do
      user = User.create!({ email: 'user@test.com', password: '123456' })

      visit root_path
      click_on 'Entrar como Usuário'
      fill_in 'E-mail',	with: user.email
      fill_in 'Senha',	with: user.password
      click_on 'Entrar'

      expect(page).to have_content 'Logout'
      expect(page).to have_content 'Profissionais disponíveis'
      expect(page).to_not have_content 'Projetos disponíveis'
    end
  end

  context 'as a freelancer' do
    it 'successfully' do
      freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })

      visit root_path
      click_on 'Entrar como Freelancer'
      fill_in 'E-mail',	with: freelancer.email
      fill_in 'Senha',	with: freelancer.password
      click_on 'Entrar'

      expect(page).to have_content 'Logout'
      expect(page).to have_content 'Projetos disponíveis'
      expect(page).to_not have_content 'Profissionais disponíveis'
    end
  end
end
require 'rails_helper'

describe 'Visit home page' do
  context 'without authentication' do
    it 'successfully' do
      visit root_path

      expect(page).to_not have_content 'Logout'
      expect(page).to_not have_content 'Profissionais disponíveis'
      expect(page).to_not have_content 'Projetos disponíveis'
    end
  end

  context 'as an user' do
    it 'successfully' do
      user = User.create!({ email: 'user@test.com', password: '123456' })

      login_as user, scope: :user
      visit root_path

      expect(page).to have_content 'user@test.com'
      expect(page).to have_content 'Logout'
      expect(page).to have_content 'Meus Projetos'
      expect(page).to have_content 'Novo Projeto'
      expect(page).to have_content 'Profissionais disponíveis'
      expect(page).to_not have_content 'Projetos disponíveis'
    end
  end

  context 'as a freelancer' do
    it 'successfully' do
      freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
      user = User.create!({ email: 'user@test.com', password: '123456' })

      login_as freelancer, scope: :freelancer
      visit root_path

      expect(page).to have_content 'freelancer@test.com'
      expect(page).to have_content 'Logout'
      expect(page).to have_content 'Projetos disponíveis'
      expect(page).to_not have_content 'Meus Projetos'
      expect(page).to_not have_content 'Novo Projeto'
      expect(page).to_not have_content 'Profissionais disponíveis'
      expect(page).to_not have_content 'user@test.com'
    end
  end
end

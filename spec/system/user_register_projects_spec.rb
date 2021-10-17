require 'rails_helper'

describe 'User register projects' do
  context 'logged in' do
    it 'successfully' do
      user = User.create!({ email: 'user@test.com', password: '123456' })
      job_presential = JobType.create!({ name: 'Presencial' })

      login_as user, scope: :user
      visit root_path
      click_on 'Novo Projeto'
      within 'form' do
        fill_in 'Título', with: 'Sistema Web'
        fill_in 'Descrição', with: 'Site de Fast Food por encomenda'
        fill_in 'Habilidades Desejadas', with: 'No Back: NodeJS, Prisma, PostgreSQL. No Front: VueJS, Sass, Tailwind CSS'
        fill_in 'Valor/Hora máximo', with: 300
        fill_in 'Data Limite', with: Date.today
        choose 'Presencial'
        check 'Disponível'
        click_on 'Criar Projeto'
      end

      expect(current_path).to_not eq new_project_path
      expect(page).to have_content 'Sistema Web'
      expect(page).to have_content 'Site de Fast Food por encomenda'
      expect(page).to have_content 'No Back: NodeJS, Prisma, PostgreSQL. No Front: VueJS, Sass, Tailwind CSS'
      expect(page).to have_content 'R$ 300,00'
      expect(page).to have_content I18n.l(Date.today)
      expect(page).to have_content 'Tipo de Trabalho Presencial'
      expect(page).to have_content /Sim/
      expect(page).to have_content 'Status Aceitando propostas'
    end
  end

  context 'logged out' do
    it 'see login page' do
      visit new_project_path

      expect(current_path).to eq new_user_session_path
      expect(page).to have_content "Para continuar, efetue login ou registre-se."
      expect(page).to_not have_content "Novo Projeto"
    end
  end
end

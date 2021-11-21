require 'rails_helper'

describe 'User register projects' do
  context 'logged in' do
    it 'successfully' do
      user = User.create!({ email: 'user@test.com', password: '123456' })
      JobType.create!({ name: 'Presencial' })

      login_as user, scope: :user
      visit root_path
      click_on 'Novo Projeto'
      within 'form' do
        fill_in 'Título', with: 'Sistema Web'
        fill_in 'Descrição', with: 'Site de Fast Food por encomenda'
        fill_in 'Habilidades Desejadas', with: 'No Back: NodeJS, Prisma, PostgreSQL.' \
                                               'No Front: VueJS, Sass, Tailwind CSS'
        fill_in 'Valor/Hora máximo', with: 300
        fill_in 'Data Limite', with: 4.months.from_now
        choose 'Presencial'
        check 'Disponível'
        click_on 'Criar Projeto'
      end

      expect(current_path).to_not eq new_project_path
      expect(page).to have_content 'Sistema Web'
      expect(page).to have_content 'Site de Fast Food por encomenda'
      within 'dl' do
        expect(page).to have_content 'No Back: NodeJS, Prisma, PostgreSQL.No Front: VueJS, Sass, Tailwind CSS'
        expect(page).to have_content 'R$ 300,00'
        expect(page).to have_content I18n.l(4.months.from_now.to_date)
        expect(page).to have_content 'Tipo de Trabalho: Presencial'
        expect(page).to have_content /Sim/
        expect(page).to have_content 'Status: Aceitando propostas'
      end
    end

    it 'and edit it' do
      user = User.create!({ email: 'user@test.com', password: '123456' })
      JobType.create!({ name: 'Presencial' })
      job_remoto = JobType.create!({ name: 'Remoto' })
      project = Project.create!({ title: 'Sistema Web',
                                  description: 'Site de Fast Food por encomenda',
                                  wanted_skills: 'No Back: NodeJS, Prisma, PostgreSQL.' \
                                                 'No Front: VueJS, Sass, Tailwind CSS',
                                  max_hour_rate: 300, deadline: 4.months.from_now,
                                  available: true, job_type: job_remoto, user: user })

      login_as user, scope: :user
      visit root_path
      click_on 'Meus Projetos'
      click_on 'Sistema Web'
      click_on 'Editar Projeto'
      within 'form' do
        fill_in 'Título', with: 'Sistema Web FUNCIONAL'
        fill_in 'Descrição', with: 'Site de Fast Food por encomenda TOP'
        fill_in 'Habilidades Desejadas', with: 'No Back: NodeJS, Prisma, PostgreSQL.' \
                                               'No Front: VueJS, Sass, Tailwind CSS ... SÓ, e tem que ser Sênior :)'
        fill_in 'Valor/Hora máximo', with: 55
        fill_in 'Data Limite', with: 6.months.from_now
        choose 'Remoto'
        uncheck 'Disponível'
        click_on 'Atualizar Projeto'
      end

      expect(current_path).to eq project_path(project)
      expect(page).to have_content 'Sistema Web FUNCIONAL'
      expect(page).to have_content 'Site de Fast Food por encomenda TOP'
      within 'dl' do
        expect(page).to have_content 'No Back: NodeJS, Prisma, PostgreSQL.' \
                                     'No Front: VueJS, Sass, Tailwind CSS ... SÓ, e tem que ser Sênior :)'
        expect(page).to have_content 'R$ 55,00'
        expect(page).to have_content I18n.l(6.months.from_now.to_date)
        expect(page).to have_content 'Tipo de Trabalho: Remoto'
        expect(page).to have_content /Não/
        expect(page).to have_content 'Status: Aceitando propostas'
      end
    end

    it 'and delete it' do
      user = User.create!({ email: 'user@test.com', password: '123456' })
      JobType.create!({ name: 'Presencial' })
      job_remoto = JobType.create!({ name: 'Remoto' })
      Project.create!({ title: 'Sistema Web',
                        description: 'Site de Fast Food por encomenda',
                        wanted_skills: 'No Back: NodeJS, Prisma, PostgreSQL.' \
                                       'No Front: VueJS, Sass, Tailwind CSS',
                        max_hour_rate: 300, deadline: 4.months.from_now,
                        available: true, job_type: job_remoto, user: user })

      login_as user, scope: :user
      visit root_path
      click_on 'Meus Projetos'
      click_on 'Sistema Web'
      click_on 'Deletar Projeto'

      expect(current_path).to eq my_projects_projects_path
      expect(page).to_not have_link 'Sistema Web'
      expect(page).to_not have_content 'Site de Fast Food por encomenda'
      expect(page).to_not have_content 'No Back: NodeJS, Prisma, PostgreSQL. No Front: VueJS, Sass, Tailwind CSS'
      expect(page).to_not have_content 'R$ 300,00'
      expect(page).to_not have_content I18n.l(4.months.ago.to_date)
      expect(page).to_not have_content 'Tipo de Trabalho: Presencial'
      expect(page).to_not have_content /Sim/
      expect(page).to_not have_content 'Status: Aceitando propostas'
    end
  end

  context 'logged out' do
    it 'see User login page' do
      visit new_project_path

      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'Para continuar, efetue login ou registre-se.'
      expect(page).to_not have_content "Criar #{I18n.t(:project, scope: 'activerecord.models')}"
    end
  end
end

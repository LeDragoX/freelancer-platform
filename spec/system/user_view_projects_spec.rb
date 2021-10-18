require 'rails_helper'

describe 'User view projects' do
  context 'on My Projects page' do
    it 'and saw 1 project' do
      user = User.create!({ email: 'user@test.com', password: '123456' })
      freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
      job_remoto = JobType.create!({ name: 'Remoto' })
      project = Project.create!({ title: 'Sistema Web',
                                  description: 'Site de Fast Food por encomenda',
                                  wanted_skills: 'No Back: NodeJS, Prisma, PostgreSQL. No Front: VueJS, Sass, Tailwind CSS',
                                  max_hour_rate: 300, deadline: 4.month.from_now,
                                  job_type: job_remoto, available: true, user: user })

      login_as user, scope: :user
      visit root_path
      click_on 'Meus Projetos'

      within 'nav' do
        expect(page).to have_content 'Meus Projetos'
        expect(page).to have_content 'Novo Projeto'
      end
      expect(page).to have_link 'Sistema Web', href: project_path(project)
      expect(page).to have_content 'R$ 300,00'
      expect(page).to_not have_content I18n.l(project.deadline) # Foi o melhor jeito consegui de testar Data
    end

    it 'and enters on a project page' do
      user = User.create!({ email: 'user@test.com', password: '123456' })
      freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
      job_presential = JobType.create!({ name: 'Presencial' })
      project = Project.create!({ title: 'Sistema Web',
                                  description: 'Site de Fast Food por encomenda',
                                  wanted_skills: 'No Back: NodeJS, Prisma, PostgreSQL. No Front: VueJS, Sass, Tailwind CSS',
                                  max_hour_rate: 300, deadline: 4.month.from_now,
                                  job_type: job_presential, available: true, user: user })

      login_as user, scope: :user
      visit root_path
      click_on 'Meus Projetos'
      click_on 'Sistema Web'

      expect(page).to have_content 'Sistema Web'
      expect(page).to have_content 'Site de Fast Food por encomenda'
      within 'dl' do
        expect(page).to have_content project.user.email
        expect(page).to have_content 'No Back: NodeJS, Prisma, PostgreSQL. No Front: VueJS, Sass, Tailwind CSS'
        expect(page).to have_content 'R$ 300,00'
        expect(page).to have_content I18n.l(project.deadline) # Foi o melhor jeito consegui de testar Data
        expect(page).to have_content 'Presencial'
        expect(page).to have_content /Sim/ # no lugar do true
        expect(page).to have_content I18n.t(project.status, scope: 'activerecord.attributes.statuses')
      end
      expect(page).to have_link 'Editar Projeto'
      expect(page).to have_link 'Deletar Projeto'
    end
  end
end
require 'rails_helper'

describe 'Freelancer view projects' do
  context 'on home page' do
    it 'and saw 1' do
      freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
      user = User.create!({ email: 'user@test.com', password: '123456' })
      job_remoto = JobType.create!({ name: "Remoto" })
      project = Project.create!({ title: "Sistema Web",
                                  description: "Site de Fast Food por encomenda",
                                  wanted_skills: "No Back: NodeJS, Prisma, PostgreSQL. No Front: VueJS, Sass, Tailwind CSS",
                                  max_hour_rate: 300, deadline: 4.month.from_now,
                                  job_type: job_remoto, available: true, status: 1, user: user })

      login_as freelancer, scope: :freelancer
      visit root_path

      expect(page).to have_link 'Sistema Web', href: project_path(project)
      expect(page).to_not have_content 'R$ 600,00'
      expect(page).to_not have_content I18n.l(project.deadline) # Foi o melhor jeito consegui de testar Data
    end

    it 'enters the project page' do
      freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
      user = User.create!({ email: 'user@test.com', password: '123456' })
      job_presential = JobType.create!({ name: "Presencial" })
      project = Project.create!({ title: "Sistema Web",
                                  description: "Site de Fast Food por encomenda",
                                  wanted_skills: "No Back: NodeJS, Prisma, PostgreSQL. No Front: VueJS, Sass, Tailwind CSS",
                                  max_hour_rate: 300, deadline: 4.month.from_now,
                                  job_type: job_presential, available: true, status: 1, user: user })

      login_as freelancer, scope: :freelancer
      visit root_path
      click_on 'Sistema Web'

      expect(page).to have_content 'Sistema Web'
      expect(page).to have_content 'Site de Fast Food por encomenda'
      expect(page).to have_content 'No Back: NodeJS, Prisma, PostgreSQL. No Front: VueJS, Sass, Tailwind CSS'
      expect(page).to have_content 'R$ 300,00'
      expect(page).to have_content I18n.l(project.deadline) # Foi o melhor jeito consegui de testar Data
      expect(page).to have_content "Presencial"
      expect(page).to have_content /true/ # Sim
      expect(page).to have_content project.user.email
    end
  end
end
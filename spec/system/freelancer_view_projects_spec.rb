require 'rails_helper'

describe 'Freelancer view projects' do
  context 'on home page' do
    it 'and saw 1' do
      freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
      user = User.create!({ email: 'user@test.com', password: '123456' })
      project = Project.create!({ title: 'Sistema Web', description: 'Site para cadastro de Comidas da pizzaria Zé Delivery',
                                  wanted_skills: 'No Back: NodeJS; PostgresSQL. No Front: VueJS',
                                  max_hour_rate: 600, deadline: 6.month.from_now,
                                  job_type: 1, available: true, status: 1, user: user })

      login_as freelancer, scope: :freelancer
      visit root_path

      expect(page).to have_link 'Sistema Web', href: project_path(project)
      expect(page).to have_content 'R$ 600,00'
      expect(page).to have_content I18n.l(project.deadline) # Foi o melhor jeito consegui de testar Data
    end

    it 'enters the project page' do
      freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
      user = User.create!({ email: 'user@test.com', password: '123456' })
      project = Project.create!({ title: 'Sistema Web', description: 'Site para cadastro de Comidas da pizzaria Zé Delivery',
                                  wanted_skills: 'No Back: NodeJS; PostgresSQL. No Front: VueJS',
                                  max_hour_rate: 600, deadline: 6.month.from_now,
                                  job_type: 1, available: true, status: 1, user: user })

      login_as freelancer, scope: :freelancer
      visit root_path
      click_on 'Sistema Web'

      expect(page).to have_content 'Sistema Web'
      expect(page).to have_content 'Site para cadastro de Comidas da pizzaria Zé Delivery'
      expect(page).to have_content 'No Back: NodeJS; PostgresSQL. No Front: VueJS'
      expect(page).to have_content 'R$ 600,00'
      expect(page).to have_content I18n.l(project.deadline) # Foi o melhor jeito consegui de testar Data
      expect(page).to have_content /1/ # Presencial
      expect(page).to have_content /true/ # Sim
      expect(page).to have_content project.user.email
    end
  end
end
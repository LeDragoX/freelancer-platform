require "rails_helper"

describe "Freelancer view projects" do
  context "with profile on home page" do
    it "and saw 1 project" do
      freelancer = Freelancer.create!({ email: "freelancer@test.com", password: "123456" })
      qa = OccupationArea.create!({ name: "Quality Assurance" })
      f_profile = Profile.create!({ full_name: "Giovanni César Lima", social_name: "Giovanni César",
                                    birth_date: 32.years.ago, formation: "Ciência da Computação",
                                    description: "Gosto de programar desde pequeno, graças a isso cheguei aonde estou.",
                                    photo: "https://i.pinimg.com/originals/47/eb/9f/47eb9f6a5f8878923282daf42e8cc95f.jpg",
                                    occupation_area: qa, freelancer: freelancer })

      user = User.create!({ email: "user@test.com", password: "123456" })
      job_remoto = JobType.create!({ name: "Remoto" })
      project = Project.create!({ title: "Sistema Web",
                                  description: "Site de Fast Food por encomenda",
                                  wanted_skills: "No Back: NodeJS, Prisma, PostgreSQL. No Front: VueJS, Sass, Tailwind CSS",
                                  max_hour_rate: 300, deadline: 4.month.from_now,
                                  available: true, job_type: job_remoto, user: user })

      login_as freelancer, scope: :freelancer
      visit root_path

      within "nav" do
        expect(page).to_not have_content "Novo Projeto"
      end
      expect(page).to have_link "Sistema Web", href: project_path(project)
      expect(page).to_not have_content "R$ 600,00"
      expect(page).to_not have_content I18n.l(project.deadline) # Foi o melhor jeito consegui de testar Data
    end

    it "enters the project page" do
      freelancer = Freelancer.create!({ email: "freelancer@test.com", password: "123456" })
      qa = OccupationArea.create!({ name: "Quality Assurance" })
      f_profile = Profile.create!({ full_name: "Giovanni César Lima", social_name: "Giovanni César",
                                    birth_date: 32.years.ago, formation: "Ciência da Computação",
                                    description: "Gosto de programar desde pequeno, graças a isso cheguei aonde estou.",
                                    photo: "https://i.pinimg.com/originals/47/eb/9f/47eb9f6a5f8878923282daf42e8cc95f.jpg",
                                    occupation_area: qa, freelancer: freelancer })

      user = User.create!({ email: "user@test.com", password: "123456" })
      job_presential = JobType.create!({ name: "Presencial" })
      project = Project.create!({ title: "Sistema Web",
                                  description: "Site de Fast Food por encomenda",
                                  wanted_skills: "No Back: NodeJS, Prisma, PostgreSQL. No Front: VueJS, Sass, Tailwind CSS",
                                  max_hour_rate: 300, deadline: 4.month.from_now,
                                  available: true, job_type: job_presential, user: user })

      login_as freelancer, scope: :freelancer
      visit root_path
      click_on "Sistema Web"

      expect(page).to have_content "Voltar para Página Inicial"
      expect(page).to have_content "Sistema Web"
      expect(page).to have_content "Site de Fast Food por encomenda"
      within "dl" do
        expect(page).to have_content project.user.email
        expect(page).to have_content "No Back: NodeJS, Prisma, PostgreSQL. No Front: VueJS, Sass, Tailwind CSS"
        expect(page).to have_content "R$ 300,00"
        expect(page).to have_content I18n.l(project.deadline)
        expect(page).to have_content "Presencial"
        expect(page).to have_content /Sim/ # no lugar do true
        expect(page).to have_content I18n.t(project.status, scope: "activerecord.attributes.statuses")
      end
      expect(page).to_not have_link "Editar Projeto"
      expect(page).to_not have_link "Deletar Projeto"
    end
  end
end
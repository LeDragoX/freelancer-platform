require "rails_helper"

describe "Freelancer makes proposal in project" do
  context "viewing a project" do
    it "successfully" do
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
      click_on "Fazer Proposta"

      within "form" do
        fill_in "Descrição", with: "Sonho com um projeto desses!"
        fill_in "Valor/Hora", with: 250
        fill_in "Horas semanais disponíveis", with: 40
        fill_in "Estimativa de entrega", with: 6.months.from_now
        click_on "Criar Proposta"
      end

      expect(current_path).to eq project_path(1)
      expect(page).to have_content "Proposta criada com sucesso!"
      expect(page).to have_content "Voltar para Página Inicial"
      expect(page).to have_content "Sistema Web"
      expect(page).to have_content "Projeto de: #{project.user.email}"
      within "div", class: "proposal" do
        expect(page).to have_content "Descrição: Sonho com um projeto desses!"
        expect(page).to have_content "Valor/Hora: R$ 250,00"
        expect(page).to have_content "Horas semanais disponíveis: 40 horas semanais"
        expect(page).to have_content "Status: Pendente"
        expect(page).to have_content "Estimativa de entrega: #{I18n.l(6.months.from_now.to_date)}"
      end
      expect(page).to have_link "Editar Proposta"
      expect(page).to have_link "Deletar Proposta"
    end

    it "edit it" do
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

      f_proposal = Proposal.create!({ description: "Sonho com um projeto desses!",
                                      hour_rate: 250, weekly_hours: 40, delivery_estimate: 6.months.from_now,
                                      project: project, freelancer: freelancer })

      login_as freelancer, scope: :freelancer
      visit root_path
      click_on "Sistema Web"
      click_on "Editar Proposta"

      within "form" do
        fill_in "Descrição", with: "Sonho com um projeto desses! Estudo até mais feliz se conseguir participar :D"
        click_on "Atualizar Proposta"
      end

      expect(current_path).to eq project_path(1)
      expect(page).to have_content "Proposta atualizada com sucesso!"
      expect(page).to have_content "Voltar para Página Inicial"
      expect(page).to have_content "Sistema Web"
      expect(page).to have_content "Projeto de: #{project.user.email}"
      within "div", class: "proposal" do
        expect(page).to have_content "Descrição: Sonho com um projeto desses! Estudo até mais feliz se conseguir participar :D"
      end
      expect(page).to have_link "Editar Proposta"
      expect(page).to have_link "Deletar Proposta"
    end

    it "delete it" do
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

      f_proposal = Proposal.create!({ description: "Sonho com um projeto desses!",
                                      hour_rate: 250, weekly_hours: 40, delivery_estimate: 6.months.from_now,
                                      project: project, freelancer: freelancer })

      login_as freelancer, scope: :freelancer
      visit root_path
      click_on "Sistema Web"
      click_on "Deletar Proposta"

      expect(current_path).to eq project_path(1)
      expect(page).to have_content "Proposta deletada com sucesso!"
      within "main" do
        expect(page).to have_content "Voltar para Página Inicial"
        expect(page).to have_content "Sistema Web"
        expect(page).to have_content "Projeto de: #{project.user.email}"
        expect(page).to have_link "Fazer Proposta", href: "/projects/1/proposals/new"
        expect(page).to_not have_text '<div class="proposals">'
        expect(page).to_not have_link "Editar Proposta"
        expect(page).to_not have_link "Deletar Proposta"
      end
    end
  end
end
require "rails_helper"

describe "Freelancer view projects with own proposals" do
  context "on my projects" do
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

      f_proposal = Proposal.create!({ description: "Sonho com um projeto desses!",
                                      hour_rate: 250, weekly_hours: 40, delivery_estimate: 6.months.from_now,
                                      project: project, freelancer: freelancer })

      login_as freelancer, scope: :freelancer
      visit root_path
      click_on "Meus Projetos"

      expect(current_path).to eq my_projects_projects_path
      within "tbody" do
        expect(page).to have_content "Sistema Web"
        expect(page).to have_content "No Back: NodeJS, Prisma, PostgreSQL. No Front: VueJS, Sass, Tailwind CSS"
        expect(page).to have_content "R$ 300,00"
        expect(page).to have_content /Presencial/
        expect(page).to have_content "user@test.com"
      end
    end
  end
end
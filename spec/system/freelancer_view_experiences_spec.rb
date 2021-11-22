require 'rails_helper'

describe 'Freelancer view experiences' do
  context 'successfully' do
    it 'on its own profile page' do
      freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
      qa = OccupationArea.create!({ name: 'Quality Assurance' })
      f_profile = Profile.create!({ full_name: 'Giovanni César Lima', social_name: 'Giovanni César',
                                    birth_date: 32.years.ago, formation: 'Ciência da Computação',
                                    description: 'Gosto de programar desde pequeno, graças a isso cheguei aonde estou.',
                                    photo: 'https://i.pinimg.com/originals/47/eb/9f/47eb9f6a5f8878923282daf42e8cc95f.jpg',
                                    occupation_area: qa, freelancer: freelancer })
      p_experience = Experience.create!({ title: 'Fast Entregas', started_at: 6.years.ago, ended_at: 5.years.ago,
                                          description: 'Desenvolvedor Full-Stack Junior',
                                          profile: f_profile })

      login_as freelancer, scope: :freelancer
      visit root_path
      click_on 'Meu Perfil'

      expect(current_path).to eq '/profiles/1'
      within 'main' do
        expect(page).to have_link 'Nova Experiência', href: new_profile_experience_path(f_profile)
        expect(page).to have_content I18n.t(:experiences, scope: 'activerecord.models')
        expect(page).to have_link 'Fast Entregas', href: profile_experience_path(f_profile, p_experience)
        expect(page).to have_content "Período: #{I18n.l(p_experience.started_at)} - #{I18n.l(p_experience.ended_at)}"
        expect(page).to have_content 'Desenvolvedor Full-Stack Junior'
      end
    end

    it 'enters on the experience page' do
      freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
      qa = OccupationArea.create!({ name: 'Quality Assurance' })
      f_profile = Profile.create!({ full_name: 'Giovanni César Lima', social_name: 'Giovanni César',
                                    birth_date: 32.years.ago, formation: 'Ciência da Computação',
                                    description: 'Gosto de programar desde pequeno, graças a isso cheguei aonde estou.',
                                    photo: 'https://i.pinimg.com/originals/47/eb/9f/47eb9f6a5f8878923282daf42e8cc95f.jpg',
                                    occupation_area: qa, freelancer: freelancer })
      p_experience = Experience.create!({ title: 'Fast Entregas', started_at: 6.years.ago, ended_at: 5.years.ago,
                                          description: 'Desenvolvedor Full-Stack Junior',
                                          profile: f_profile })

      login_as freelancer, scope: :freelancer
      visit root_path
      click_on 'Meu Perfil'
      click_on 'Fast Entregas'

      within 'main' do
        expect(page).to have_link "Voltar para #{I18n.t(:profile, scope: 'activerecord.models')}",
                                  href: profile_path(f_profile)
        expect(page).to have_content 'Fast Entregas'
        expect(page).to have_content "Período: #{I18n.l(p_experience.started_at)} - #{I18n.l(p_experience.ended_at)}"
        expect(page).to have_content 'Desenvolvedor Full-Stack Junior'
        expect(page).to have_link "Editar #{I18n.t(:experience, scope: 'activerecord.models')}",
                                  href: edit_profile_experience_path(f_profile, p_experience)
        expect(page).to have_link "Deletar #{I18n.t(:experience, scope: 'activerecord.models')}",
                                  href: profile_experience_path(f_profile, p_experience)
      end
    end
  end
end

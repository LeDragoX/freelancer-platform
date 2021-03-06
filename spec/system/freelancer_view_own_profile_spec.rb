require 'rails_helper'

describe 'Freelancer view own Profile' do
  context 'successfully' do
    it 'on home page link' do
      freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
      qa = OccupationArea.create!({ name: 'Quality Assurance' })
      f_profile = Profile.create!({ full_name: 'Giovanni César Lima', social_name: 'Giovanni César',
                                    birth_date: 32.years.ago, formation: 'Ciência da Computação',
                                    description: 'Gosto de programar desde pequeno, graças a isso cheguei aonde estou.',
                                    photo: 'https://i.pinimg.com/originals/47/eb/9f/47eb9f6a5f8878923282daf42e8cc95f.jpg',
                                    occupation_area: qa, freelancer: freelancer })

      login_as freelancer, scope: :freelancer
      visit root_path
      within 'nav' do
        click_on 'Meu Perfil'
      end

      expect(current_path).to eq profile_path(f_profile)
      expect(page).to have_link 'Editar Perfil', href: edit_profile_path(f_profile)
      expect(page).to have_content 'Giovanni César Lima (Giovanni César)'
      expect(page).to have_content 'Quality Assurance'
      expect(page).to have_css('img[alt=photo]')
      within 'dl' do
        expect(page).to have_content 'Gosto de programar desde pequeno, graças a isso cheguei aonde estou.'
        expect(page).to have_content I18n.l(f_profile.birth_date)
        expect(page).to have_content 'Ciência da Computação'
        expect(page).to have_content 'freelancer@test.com'
      end
      expect(page).to have_content I18n.t(:experiences, scope: 'activerecord.models')
    end
  end
end

require 'rails_helper'

describe 'Freelancer register Profile' do
  context 'on home page' do
    it 'successfully' do
      freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
      qa = OccupationArea.create!({ name: 'Quality Assurance' })

      login_as freelancer, scope: :freelancer
      visit root_path
      within 'nav' do
        click_on freelancer.email
      end

      within 'form' do
        fill_in 'Nome Completo', with: 'Giovanni César Lima'
        fill_in 'Nome Social', with: 'Giovanni César'
        fill_in 'Data de Nascimento', with: 32.years.ago
        fill_in 'Formação', with: 'Ciência da Computação'
        fill_in 'Descrição', with: 'Gosto de programar desde pequeno, graças a isso cheguei aonde estou.'
        fill_in 'Foto', with: 'https://i.pinimg.com/originals/47/eb/9f/47eb9f6a5f8878923282daf42e8cc95f.jpg'
        select 'Quality Assurance', from: 'Área de Atuação'
      end
      click_on 'Criar Perfil'

      expect(current_path).to eq '/profiles/1'
      expect(page).to have_content 'Giovanni César Lima (Giovanni César)'
      expect(page).to have_content 'Quality Assurance'
      within 'dl' do
        expect(page).to have_content 'Gosto de programar desde pequeno, graças a isso cheguei aonde estou.'
        expect(page).to have_content I18n.l(Date.today - 32.years)
        expect(page).to have_content 'Ciência da Computação'
        expect(page).to have_content 'freelancer@test.com'
      end
      expect(page).to have_link I18n.t(:experiences, scope: 'activerecord.models'), href: '/profiles/1/experiences'
      expect(page).to have_link 'Editar Perfil', href: '/profiles/1/edit'
    end

    it 'and edit it' do
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
        click_on freelancer.email
      end
      click_on 'Editar Perfil'
      within 'form' do
        fill_in 'Nome Completo', with: 'Giovanni César Lima'
        fill_in 'Nome Social', with: 'Giovanni César'
        fill_in 'Data de Nascimento', with: 40.years.ago
        fill_in 'Formação', with: 'Ciência da Computação'
        fill_in 'Descrição', with: 'Gosto de programar desde pequeno, graças a isso cheguei aonde estou.'
        fill_in 'Foto', with: 'https://i.pinimg.com/originals/47/eb/9f/47eb9f6a5f8878923282daf42e8cc95f.jpg'
        select 'Quality Assurance', from: 'Área de Atuação'
      end
      click_on 'Atualizar Perfil'

      expect(current_path).to eq '/profiles/1'
      expect(page).to have_content 'Giovanni César Lima (Giovanni César)'
      expect(page).to have_content 'Quality Assurance'
      within 'dl' do
        expect(page).to have_content 'Gosto de programar desde pequeno, graças a isso cheguei aonde estou.'
        expect(page).to have_content I18n.l(Date.today - 40.years)
        expect(page).to have_content 'Ciência da Computação'
        expect(page).to have_content 'freelancer@test.com'
      end
      expect(page).to have_link I18n.t(:experiences, scope: 'activerecord.models'), href: '/profiles/1/experiences'
      expect(page).to have_link 'Editar Perfil', href: '/profiles/1/edit'
    end
  end
end
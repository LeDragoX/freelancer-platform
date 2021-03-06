require 'rails_helper'

describe 'Freelancer register experiences' do
  context 'successfully' do
    it 'logged as freelancer' do
      freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
      qa = OccupationArea.create!({ name: 'Quality Assurance' })
      Profile.create!({ full_name: 'Giovanni César Lima', social_name: 'Giovanni César',
                        birth_date: 32.years.ago, formation: 'Ciência da Computação',
                        description: 'Gosto de programar desde pequeno, graças a isso cheguei aonde estou.',
                        photo: 'https://i.pinimg.com/originals/47/eb/9f/47eb9f6a5f8878923282daf42e8cc95f.jpg',
                        occupation_area: qa, freelancer: freelancer })

      login_as freelancer, scope: :freelancer
      visit root_path
      click_on 'Meu Perfil'
      click_on 'Nova Experiência'
      within 'form' do
        fill_in 'Título', with: 'Valve'
        fill_in 'Data de Início', with: 10.years.ago
        fill_in 'Data de Término', with: Time.zone.now.to_date
        fill_in 'Descrição',
                with: 'Trabalho com APIs de e-commerces, para consumir dentro da Loja da Steam.' \
                      'Sempre há algum trabalho de re-design, refatoração, e limpeza de código para realizar.'
        click_on "Criar #{I18n.t(:experience, scope: 'activerecord.models')}"
      end

      expect(current_path).to eq '/profiles/1/experiences/1'
      within 'main' do
        expect(page).to have_link "Voltar para #{I18n.t(:profile, scope: 'activerecord.models')}"
        expect(page).to have_content 'Valve'
        expect(page).to have_content "Período: #{I18n.l(10.years.ago.to_date)} - #{I18n.l(Time.zone.now.to_date)}"
        expect(page).to have_content 'Trabalho com APIs de e-commerces, para consumir dentro da Loja da Steam.' \
                                     'Sempre há algum trabalho de re-design, ' \
                                     'refatoração, e limpeza de código para realizar.'
      end
    end

    it 'edit it' do
      freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
      qa = OccupationArea.create!({ name: 'Quality Assurance' })
      f_profile = Profile.create!({ full_name: 'Giovanni César Lima', social_name: 'Giovanni César',
                                    birth_date: 32.years.ago, formation: 'Ciência da Computação',
                                    description: 'Gosto de programar desde pequeno, graças a isso cheguei aonde estou.',
                                    photo: 'https://i.pinimg.com/originals/47/eb/9f/47eb9f6a5f8878923282daf42e8cc95f.jpg',
                                    occupation_area: qa, freelancer: freelancer })
      Experience.create!({ title: 'Valve', started_at: 10.years.ago, ended_at: Time.zone.now.to_date,
                           description: 'Trabalho com APIs de e-commerces, para consumir dentro da Loja da Steam.' \
                                        'Sempre há algum trabalho de re-design, ' \
                                        'refatoração, e limpeza de código para realizar.',
                           profile: f_profile })

      login_as freelancer, scope: :freelancer
      visit root_path
      click_on 'Meu Perfil'
      click_on 'Valve'
      click_on "Editar #{I18n.t(:experience, scope: 'activerecord.models')}"
      within 'form' do
        fill_in 'Título', with: 'Valve STEAM'
        fill_in 'Data de Início', with: 15.years.ago
        fill_in 'Data de Término', with: Time.zone.now.to_date
        fill_in 'Descrição',
                with: 'Trabalho com APIs de e-commerces, para consumir dentro da Loja da Steam.' \
                      'Sempre há algum trabalho de re-design, refatoração, e limpeza de código para realizar.'
        click_on "Atualizar #{I18n.t(:experience, scope: 'activerecord.models')}"
      end

      expect(current_path).to eq '/profiles/1/experiences/1'
      within 'main' do
        expect(page).to have_link "Voltar para #{I18n.t(:profile, scope: 'activerecord.models')}"
        expect(page).to have_content 'Valve STEAM'
        expect(page).to have_content "Período: #{I18n.l(15.years.ago.to_date)} - #{I18n.l(Time.zone.now.to_date)}"
        expect(page).to have_content 'Trabalho com APIs de e-commerces, para consumir dentro da Loja da Steam.' \
                                     'Sempre há algum trabalho de re-design, ' \
                                     'refatoração, e limpeza de código para realizar.'
      end
    end

    it 'delete it' do
      freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
      qa = OccupationArea.create!({ name: 'Quality Assurance' })
      f_profile = Profile.create!({ full_name: 'Giovanni César Lima', social_name: 'Giovanni César',
                                    birth_date: 32.years.ago, formation: 'Ciência da Computação',
                                    description: 'Gosto de programar desde pequeno, graças a isso cheguei aonde estou.',
                                    photo: 'https://i.pinimg.com/originals/47/eb/9f/47eb9f6a5f8878923282daf42e8cc95f.jpg',
                                    occupation_area: qa, freelancer: freelancer })
      Experience.create!({ title: 'Valve', started_at: 10.years.ago, ended_at: Time.zone.now.to_date,
                           description: 'Trabalho com APIs de e-commerces, para consumir dentro da Loja da Steam.' \
                                        'Sempre há algum trabalho de re-design, ' \
                                        'refatoração, e limpeza de código para realizar.',
                           profile: f_profile })

      login_as freelancer, scope: :freelancer
      visit root_path
      click_on 'Meu Perfil'
      click_on 'Valve'
      click_on "Deletar #{I18n.t(:experience, scope: 'activerecord.models')}"

      expect(current_path).to eq '/profiles/1'
      within 'main' do
        expect(page).to_not have_content 'Valve STEAM'
        expect(page).to_not have_content "Período: #{I18n.l(15.years.ago.to_date)} - #{I18n.l(Time.zone.now.to_date)}"
        expect(page).to_not have_content 'Trabalho com APIs de e-commerces, para consumir dentro da Loja da Steam.' \
                                         'Sempre há algum trabalho de re-design, ' \
                                         'refatoração, e limpeza de código para realizar.'
      end
    end
  end

  context 'unsuccessfully' do
    it 'logged out' do
      freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
      qa = OccupationArea.create!({ name: 'Quality Assurance' })
      Profile.create!({ full_name: 'Giovanni César Lima', social_name: 'Giovanni César',
                        birth_date: 32.years.ago, formation: 'Ciência da Computação',
                        description: 'Gosto de programar desde pequeno, graças a isso cheguei aonde estou.',
                        photo: 'https://i.pinimg.com/originals/47/eb/9f/47eb9f6a5f8878923282daf42e8cc95f.jpg',
                        occupation_area: qa, freelancer: freelancer })

      visit new_profile_experience_path(1)

      expect(current_path).to eq new_freelancer_session_path
      expect(page).to have_content 'Para continuar, efetue login ou registre-se.'
      expect(page).to_not have_content "Criar #{I18n.t(:experience, scope: 'activerecord.models')}"
    end

    it 'fill fields incorrectly' do
      freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
      qa = OccupationArea.create!({ name: 'Quality Assurance' })
      profile = Profile.create!({ full_name: 'Giovanni César Lima', social_name: 'Giovanni César',
                                  birth_date: 32.years.ago, formation: 'Ciência da Computação',
                                  description: 'Gosto de programar desde pequeno, graças a isso cheguei aonde estou.',
                                  photo: 'https://i.pinimg.com/originals/47/eb/9f/47eb9f6a5f8878923282daf42e8cc95f.jpg',
                                  occupation_area: qa, freelancer: freelancer })

      login_as freelancer, scope: :freelancer
      visit root_path
      click_on 'Meu Perfil'
      click_on 'Nova Experiência'
      within 'form' do
        fill_in 'Título', with: ''
        fill_in 'Data de Início', with: Time.zone.now.to_date
        fill_in 'Data de Término', with: 10.years.ago
        fill_in 'Descrição',
                with: ''
        click_on "Criar #{I18n.t(:experience, scope: 'activerecord.models')}"
      end

      expect(current_path).to eq profile_experiences_path(profile)
      within 'main' do
        expect(page).to have_link "Voltar para #{I18n.t(:profile, scope: 'activerecord.models')}"
        expect(page).to have_content 'Título não pode ficar em branco'
        expect(page).to have_content 'Título é muito curto (mínimo: 3 caracteres)'
        expect(page).to have_content 'Data de Início não pode ser maior do que Data de Término'
        expect(page).to have_content 'Data de Término não pode ser menor do que Data de Início'
        expect(page).to have_content 'Descrição não pode ficar em branco'
        expect(page).to have_content 'Descrição é muito curto (mínimo: 20 caracteres)'
      end
    end
  end
end

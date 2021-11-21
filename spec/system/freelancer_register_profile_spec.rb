require 'rails_helper'

describe 'Freelancer register Profile' do
  context 'on home page' do
    context 'successfully' do
      it 'create it' do
        freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
        OccupationArea.create!({ name: 'Quality Assurance' })

        login_as freelancer, scope: :freelancer
        visit root_path

        within 'form' do
          fill_in 'Nome Completo', with: 'Giovanni César Lima'
          fill_in 'Nome Social', with: 'Giovanni César'
          fill_in 'Data de Nascimento', with: 32.years.ago
          fill_in 'Formação', with: 'Ciência da Computação'
          fill_in 'Descrição', with: 'Gosto de programar desde pequeno, graças a isso cheguei aonde estou.'
          fill_in 'Foto', with: 'https://i.pinimg.com/originals/47/eb/9f/47eb9f6a5f8878923282daf42e8cc95f.jpg'
          select 'Quality Assurance', from: 'Área de Atuação'
          click_on 'Criar Perfil'
        end

        expect(current_path).to eq '/profiles/1'
        within 'main' do
          expect(page).to have_content 'Giovanni César Lima (Giovanni César)'
          expect(page).to have_content 'Quality Assurance'
          expect(page).to have_css('img[alt=photo]')
          within 'dl' do
            expect(page).to have_content 'Gosto de programar desde pequeno, graças a isso cheguei aonde estou.'
            expect(page).to have_content I18n.l(32.years.ago.to_date)
            expect(page).to have_content 'Ciência da Computação'
            expect(page).to have_content 'freelancer@test.com'
          end
          expect(page).to have_content I18n.t(:experiences, scope: 'activerecord.models')
          expect(page).to have_link 'Editar Perfil', href: '/profiles/1/edit'
        end
      end

      it 'and edit it' do
        freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
        qa = OccupationArea.create!({ name: 'Quality Assurance' })
        Profile.create!({ full_name: 'Giovanni César Lima', social_name: 'Giovanni César',
                          birth_date: 32.years.ago, formation: 'Ciência da Computação',
                          description: 'Gosto de programar desde pequeno, ' \
                                       'graças a isso cheguei aonde estou.',
                          photo: 'https://i.pinimg.com/originals/47/eb/9f/47eb9f6a5f8878923282daf42e8cc95f.jpg',
                          occupation_area: qa, freelancer: freelancer })

        login_as freelancer, scope: :freelancer
        visit root_path
        within 'nav' do
          click_on 'Meu Perfil'
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
        within 'main' do
          expect(page).to have_content 'Giovanni César Lima (Giovanni César)'
          expect(page).to have_content 'Quality Assurance'
          expect(page).to have_css('img[alt=photo]')
          within 'dl' do
            expect(page).to have_content 'Gosto de programar desde pequeno, graças a isso cheguei aonde estou.'
            expect(page).to have_content I18n.l(40.years.ago.to_date)
            expect(page).to have_content 'Ciência da Computação'
            expect(page).to have_content 'freelancer@test.com'
          end
          expect(page).to have_content I18n.t(:experiences, scope: 'activerecord.models')
          expect(page).to have_link 'Editar Perfil', href: '/profiles/1/edit'
        end
      end
    end

    context 'fail with validations' do
      it 'dont create it' do
        freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
        OccupationArea.create!({ name: 'Quality Assurance' })

        login_as freelancer, scope: :freelancer
        visit root_path

        within 'form' do
          fill_in 'Nome Completo', with: ''
          fill_in 'Nome Social', with: ''
          fill_in 'Data de Nascimento', with: ''
          fill_in 'Formação', with: ''
          fill_in 'Descrição', with: ''
          fill_in 'Foto', with: ''
          select '', from: 'Área de Atuação'
          click_on 'Criar Perfil'
        end

        expect(current_path).to eq '/profiles'
        expect(page).to have_content 'Erro ao criar perfil'
        within 'main' do
          expect(page).to_not have_content 'Voltar para Página Inicial'
          expect(page).to have_content 'não pode ficar em branco', count: 4
          expect(page).to have_content 'é muito curto (mínimo: 3 caracteres)', count: 1
          expect(page).to have_content 'é muito curto (mínimo: 1 caracter)', count: 1
        end
      end

      it 'dont edit it' do
        freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
        qa = OccupationArea.create!({ name: 'Quality Assurance' })
        Profile.create!({ full_name: 'Giovanni César Lima', social_name: 'Giovanni César',
                          birth_date: 32.years.ago, formation: 'Ciência da Computação',
                          description: 'Gosto de programar desde pequeno, ' \
                                       'graças a isso cheguei aonde estou.',
                          photo: 'https://i.pinimg.com/originals/47/eb/9f/47eb9f6a5f8878923282daf42e8cc95f.jpg',
                          occupation_area: qa, freelancer: freelancer })

        login_as freelancer, scope: :freelancer
        visit root_path
        within 'nav' do
          click_on 'Meu Perfil'
        end
        click_on 'Editar Perfil'
        within 'form' do
          fill_in 'Data de Nascimento', with: 15.years.ago
        end
        click_on 'Atualizar Perfil'

        expect(current_path).to eq '/profiles/1'
        within 'main' do
          expect(page).to have_content 'Data de Nascimento não pode ser menor que 16 anos ' \
                                       "(maior que #{I18n.l(16.years.ago.to_date)})"
        end
      end
    end
  end
end

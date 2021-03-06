require 'rails_helper'

describe 'Visitor login' do
  context 'successfully' do
    it 'as an user' do
      user = User.create!({ email: 'user@test.com', password: '123456' })

      visit root_path
      click_on 'Entrar como Usuário'
      fill_in 'E-mail',	with: user.email
      fill_in 'Senha',	with: user.password
      click_on 'Entrar'

      within 'nav' do
        expect(page).to have_content 'user@test.com'
        expect(page).to have_link 'Meus Projetos'
        expect(page).to have_link 'Novo Projeto'
        expect(page).to have_link 'Sair'
      end
      expect(page).to have_content 'Profissionais disponíveis'
      expect(page).to_not have_content 'Projetos disponíveis'
    end

    context 'as a freelancer' do
      it 'with a profile' do
        freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
        qa = OccupationArea.create!({ name: 'Quality Assurance' })
        Profile.create!({ full_name: 'Giovanni César Lima', social_name: 'Giovanni César',
                          birth_date: 32.years.ago, formation: 'Ciência da Computação',
                          description: 'Gosto de programar desde pequeno, graças a isso cheguei aonde estou.',
                          photo: 'https://i.pinimg.com/originals/47/eb/9f/47eb9f6a5f8878923282daf42e8cc95f.jpg',
                          occupation_area: qa, freelancer: freelancer })

        visit root_path
        click_on 'Entrar como Freelancer'
        fill_in 'E-mail',	with: freelancer.email
        fill_in 'Senha',	with: freelancer.password
        click_on 'Entrar'

        within 'nav' do
          expect(page).to have_link 'Meu Perfil'
          expect(page).to_not have_link 'Novo Projeto'
          expect(page).to have_link 'Sair'
        end

        expect(page).to have_content 'Projetos disponíveis'
        expect(page).to_not have_content 'Profissionais disponíveis'
      end

      it 'without a profile' do
        freelancer = Freelancer.create!({ email: 'freelancer@test.com', password: '123456' })
        OccupationArea.create!({ name: 'Quality Assurance' })

        visit root_path
        click_on 'Entrar como Freelancer'
        fill_in 'E-mail',	with: freelancer.email
        fill_in 'Senha',	with: freelancer.password
        click_on 'Entrar'

        within 'nav' do
          expect(page).to have_link 'Meu Perfil'
          expect(page).to_not have_link 'Novo Projeto'
          expect(page).to have_link 'Sair'
        end

        expect(page).to_not have_content 'Projetos disponíveis'
        expect(page).to_not have_content 'Profissionais disponíveis'

        within 'form' do
          expect(page).to have_content 'Nome Completo'
          expect(page).to have_content 'Nome Social'
          expect(page).to have_content 'Data de Nascimento'
          expect(page).to have_content 'Formação'
          expect(page).to have_content 'Descrição'
          expect(page).to have_content 'Foto'
          expect(page).to have_content 'Quality Assurance'
        end
      end
    end
  end
end

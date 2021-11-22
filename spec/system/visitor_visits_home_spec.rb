require 'rails_helper'

describe 'Visitor ' do
  context 'successfully' do
    it 'visits home page' do
      visit root_path

      within 'nav' do
        expect(page).to_not have_link 'Meus Projetos'
        expect(page).to_not have_link 'Novo Projeto'
        expect(page).to_not have_link 'Sair'
      end
      expect(page).to_not have_content 'Profissionais disponíveis'
      expect(page).to_not have_content 'Projetos disponíveis'
    end
  end

  context "unsuccessfully" do
    it 'enters unauthorized page' do
      visit '/profiles/1'

      expect(current_path).to eq '/'
      expect(page).to have_content 'Você precisa estar logado para acessar esta seção.'
    end
  end
end

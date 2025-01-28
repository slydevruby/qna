require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe 'GET #index' do
    let(:fab_questions) { create_list(:question, 3) }

    before { get :index }

    it 'fills in an array with questions' do
      expect(assigns(:questions)).to match_array(fab_questions)
    end

    it 'renders index view template' do
      expect(response).to render_template :index
    end
  end
end

require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:new_question) { create(:question) }

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

  describe 'GET #show' do
    before { get :show, params: { id: new_question } }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq new_question
    end

    it 'renders show view template' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'assigns new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view template' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: new_question } }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq new_question
    end

    it 'renders edit view template' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves created question in database' do
        count = Question.count
        # post :create, params: { question: { title: '123', body: '123' } }
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
      end
      it 'rerenders new view' do
      end
    end
  end
end

require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:new_question) { FactoryBot.create(:question) }

  describe 'GET #index' do
    let(:fab_questions) { FactoryBot.create_list(:question, 3) }

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
        expect do
          post :create, params: { question: FactoryBot.attributes_for(:question) }
        end.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: FactoryBot.attributes_for(:question) }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect do
          post :create, params: { question: FactoryBot.attributes_for(:question, :invalid) }
        end.to_not change(Question, :count)
      end
      it 'rerenders new view' do
        post :create, params: { question: FactoryBot.attributes_for(:question, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:new_question) { FactoryBot.create(:question) }

    it 'deletes the question' do
      expect { delete :destroy, params: { id: new_question } }.to change(Question, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, params: { id: new_question }
      expect(response).to redirect_to questions_path
    end
  end

  describe 'PATH #update' do
    context 'with valid attributes' do
      it 'assigns the requested question to @question' do
        patch :update, params: { id: new_question, question: FactoryBot.attributes_for(:question) }
        expect(assigns(:question)).to eq new_question
      end

      it 'changes question attributes' do
        patch :update, params: { id: new_question, question: { title: 'new title', body: 'new body' } }
        new_question.reload
        expect(new_question.title).to eq 'new title'
        expect(new_question.body).to eq 'new body'
      end

      it 'redirects to updated question' do
        patch :update, params: { id: new_question, question: FactoryBot.attributes_for(:question) }
        expect(response).to redirect_to new_question
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: new_question, question: FactoryBot.attributes_for(:question, :invalid) } }

      it 'does not change question' do
        new_question.reload
        expect(new_question.title).to eq FactoryBot.attributes_for(:question)[:title]
        expect(new_question.body).to eq FactoryBot.attributes_for(:question)[:body]
      end
      it 'rerender edit view' do
        expect(response).to render_template :edit
      end
    end
  end
end

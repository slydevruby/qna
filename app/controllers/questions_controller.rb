class QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :edit]

  def index
    @questions = Question.all
  end

  def show
  end

  def edit
  end

  def create
    @question = Question.create(question_params)
  end
  
  def new
    @question = Question.new
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end

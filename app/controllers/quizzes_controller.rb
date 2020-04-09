class QuizzesController < ApplicationController

  before_action :require_user, except: [:index]
  before_action :require_admin, except: [:index, :show]

  def index
    if logged_in? and current_user.admin?
      @quizzes = Quiz.paginate(page: params[:page], per_page: 6)
    else
      @quizzes = Quiz.where(id: Question.select("quiz_id").group(:quiz_id).having("count(id)>1")).paginate(page: params[:page], per_page: 6)
    end
        
  end
  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    if @quiz.save
      flash[:success] = "Quiz was successfully created"
      redirect_to quiz_path(@quiz)
    else
      render 'new'
    end
  end

  def edit
    @quiz = Quiz.find(params[:id])
  end

  def update
    @quiz = Quiz.find(params[:id])

    if @quiz.update(quiz_params)
      flash[:success] = "Quiz was successfully updated"
      redirect_to quiz_path(@quiz)
    else
      render 'edit'
    end

  end

  def show
    @quiz = Quiz.find(params[:id])
    @questions = Question.where(quiz_id: params[:id].to_i)
    if !current_user.admin? && @questions.length()<2 
      redirect_to quizzes_path
    end
    @question = Question.new
    if params.has_key?(:question_messages)
      @question_messages = params[:question_messages] 
    else
      @question_messages = ""
    end
    if params.has_key?(:option_messages)
      @option_messages = params[:option_messages] 
    else
      @option_messages = ""
    end
    
    @question_all = @questions.paginate(page: params[:page], per_page: 5)
    @total_score = Question.where(quiz_id: params[:id].to_i).sum(:score)
    @option = Option.new
    @option_all = Option.where(question_id: Question.where(quiz_id: params[:id].to_i))
  end

  def destroy
    @quiz = Quiz.find(params[:id])
    @quiz.destroy
    flash[:danger] = "Quiz was successfully deleted"
    redirect_to quizzes_path
  end

  def editQuestion
    @each_question = Question.find(params[:each_question].to_i)
    if params.has_key?(:question_messages)
      @question_messages = params[:question_messages] 
    else
      @question_messages = ""
    end
  end

  def editOption
    @each_option = Option.find(params[:each_option].to_i)
    @each_question = Question.find(@each_option.question_id)
    if params.has_key?(:option_messages)
      @option_messages = params[:option_messages] 
    else
      @option_messages = ""
    end
  end

  private

  def quiz_params

    params.require(:quiz).permit(:name, category_ids: [])

  end
end

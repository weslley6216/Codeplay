class CoursesController < ApplicationController
  before_action :set_course, only: %i[edit update show]
  
  def index
    @courses = Course.all
  end

  def show
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course
    else
      render :new
    end
  end

  def update
    @course.update(course_params)
    redirect_to @course
    flash[:notice] = 'Curso atualizado com sucesso!'
  end


  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :code, :price, :enrollment_deadline)
  end
end
class LessonsController < ApplicationController
  def index
    @course = Course.find(params[:course_id])
  end

  def new
    @course = Course.find(params[:course_id])
    @lesson = Lesson.new
  end

  def create
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.build(lesson_params)
    if @lesson.save
      redirect_to course_lessons_path(@course)
    else
      render :new
    end
  end

  def edit
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.find(params[:id])
  end

  def update
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.find(params[:id])
    if @lesson.update(lesson_params)
      redirect_to course_lessons_path(@course), notice: 'Aula atualizada com sucesso'
    else
      render :edit
    end
  end

  private
  
  def lesson_params
    params.require(:lesson).permit(:name, :content, :course_id)
  end
end
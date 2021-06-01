class Admin::LessonsController < ApplicationController
  before_action :authenticate_user!, only: %i[show]
  before_action :set_course, only: %i[index new create edit update destroy]
  before_action :set_lesson, only: %i[show edit update destroy]
  before_action :user_has_enrollment?, only: %i[show]

  def show
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = @course.lessons.build(lesson_params)
    if @lesson.save
      redirect_to admin_course_lessons_path(@course), notice: t('messages.lesson_created')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to admin_course_lessons_path(@course), notice: t('messages.lesson_updated')
    else
      render :edit
    end
  end

  def destroy
    @lesson.destroy
    redirect_to admin_course_lessons_path(@course), notice: t('messages.lesson_removed')
  end

  private
  
  def lesson_params
    params.require(:lesson).permit(:name, :content, :duration)
  end

  def user_has_enrollment?
    redirect_to [:admin, @lesson.course] unless current_user.courses.include?(@lesson.course)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end
end
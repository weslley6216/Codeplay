class User::LessonsController < UsersController
  before_action :set_lesson, only: %i[show]
  before_action :user_has_enrollment?, only: %i[show]

  def show
  end

  def edit
  end

  private

  def user_has_enrollment?
    redirect_to [:user, @lesson.course] unless current_user.courses.include?(@lesson.course)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end
end
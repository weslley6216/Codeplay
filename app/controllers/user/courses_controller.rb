class User::CoursesController < UsersController
  before_action :set_course, only: %i[edit update show destroy enroll]
  
  def index
    @courses = Course.all
  end

  def show
  end

  def enroll
    current_user.enrollments.create(course: @course, price: @course.price)
    redirect_to my_enrolls_user_courses_path, notice: 'Curso comprado com sucesso'
  end

  def my_enrolls
    @enrollments = current_user.enrollments
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :code, :price, :enrollment_deadline, :instructor_id)
  end

end
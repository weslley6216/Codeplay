class Admin::CoursesController < AdminController
  before_action :set_course, only: %i[edit update show destroy enroll]

  def index
    @courses = Course.all
  end

  def show; end

  def new
    @instructors = Instructor.all
    @course = Course.new
  end

  def edit
    @instructors = Instructor.all
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to [:admin, @course], notice: t('messages.course_created')
    else
      @instructors = Instructor.all
      render :new
    end
  end

  def update
    if @course.update(course_params)
      redirect_to [:admin, @course], notice: t('messages.course_updated')
    else
      @instructors = Instructor.all
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to admin_courses_path, notice: 'Curso removido com sucesso'
  end

  def enroll; end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :code, :price, :enrollment_deadline, :instructor_id)
  end
end

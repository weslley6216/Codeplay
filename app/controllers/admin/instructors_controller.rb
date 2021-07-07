class Admin::InstructorsController < AdminController
  def index
    @instructors = Instructor.all
  end

  def show
    @instructor = Instructor.find(params[:id])
  end

  def new
    @instructor = Instructor.new
  end

  def create
    @instructor = Instructor.new(instructor_params)
    if @instructor.save
      redirect_to [:admin, @instructor], notice: t('messages.instructor_created')
    else
      render :new
    end
  end

  def edit
    @instructor = Instructor.find(params[:id])
  end

  def update
    @instructor = Instructor.find(params[:id])
    if @instructor.update(instructor_params)
      redirect_to [:admin, @instructor], notice: t('messages.instructor_uptaded')
    else
      render :edit
    end
  end

  def destroy
    @instructor = Instructor.find(params[:id])
    if @instructor.courses.empty?
      @instructor.destroy
      redirect_to admin_instructors_path, notice: t('messages.instructor_removed')
    else
      redirect_to [:admin, @instructor], notice: t('messages.instructor_removed_error')
    end
  end

  private

  def instructor_params
    params.require(:instructor).permit(:name, :email, :bio, :profile_picture)
  end
end

class Api::V1::CoursesController < ActionController::API
  def index
    @courses = Course.all
    render json: @courses.as_json(except: %i[id created_at updated_at instructor_id],
                                  include: { instructor: {
                                    except: %i[id created_at updated_at]
                                  } })
  end
end

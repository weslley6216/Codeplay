class UsersController < ActionController::Base
  layout 'user'
  before_action :authenticate_user!
end
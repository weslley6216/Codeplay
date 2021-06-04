module LoginMacros
  def login_admin
    admin = Admin.create!(email: 'admin@admin.com',
                          password: '123456')

    login_as admin, scope: :admin

  end

  def login_user
    user = User.create!(email: 'user@user.com',
                        password: '123456')
    
    login_as user, scope: :user
    
  end
end
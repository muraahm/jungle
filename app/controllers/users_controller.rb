class UsersController < ApplicationController
  def new
  end

  def create
   if !user_exists?
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to :root
    else
      render :new
    end
   else
    render :new
   end
  end 

  private
  def user_exists?
    User.find_by_email(user_params[:email])
  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end

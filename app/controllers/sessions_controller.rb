class SessionsController < ApplicationController
  def new
  end

  def create #creating a SESSION, not a user
    user = User.find_by_email(user_params[:email])
    if (user && user.authenticate(user_params[:password]))
      session[:user_id] = user.id
      redirect_to "/users/#{session[:user_id]}"
    else
      flash[:error] = "Invalid"
      redirect_to :back
    end
  end

  def destroy
  	reset_session
  	redirect_to "/sessions/new"
  end

  private
  def user_params
  	params.require(:user).permit(:email, :password)
  end
end

class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  # before_action :require_login, only: [:index, :show, :edit, :update, :destroy]

  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
  	User.all
  end
  
  def show
  	# @user = User.with_secrets.where(id: params[:id])
  	@user = User.find(params[:id])
  	@secrets = @user.secrets
  end

  def new
  end

  def create

  	user = User.new(user_params)
  	if user.save
  		# redirect_to "sessions/create" this breaks.
  	  session[:user_id] = user.id
  	  redirect_to "/users/#{User.last.id}"
  	else
  	  flash[:errors] = user.errors.full_messages
      redirect_to :back
    end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	user = User.find(params[:id])
    user.update(user_params)
    if (user.save)
      redirect_to "/users/#{params[:id]}"
    else
      flash[:errors] = user.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
  	User.find(params[:id]).destroy
  	reset_session
  	redirect_to "/sessions/new"
  end

  private
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end

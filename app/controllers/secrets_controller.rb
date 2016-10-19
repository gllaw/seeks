class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]

  def index
  	@secrets = Secret.all
  end

  def create
  	Secret.create(secret_params)
  	redirect_to "/users/#{current_user.id}"
  end

  def like_create
  	Like.create(like_params)
  	redirect_to :back
  end

  def destroy
  	secret = Secret.find(params[:id])
  	secret.delete if secret.user == current_user
  	
  	redirect_to "/users/#{current_user.id}"
  end

  private
  def secret_params
  	params.require(:secret).permit(:content, :user_id)
  end

  def like_params
  	params.require(:like).permit(:secret_id, :user_id)
  end

end

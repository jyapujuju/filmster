class BalletsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user
  def create
    current_user.vote(@user)
  end

  def destroy
    current_user.devote(@user)
  end

  private
  def check_user
    return if current_user.ballets.find_by(review_id: params[:id])
    flash[:success] = "you can't vote yourself!"
    redirect_to root_path
  end
end

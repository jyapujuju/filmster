class VotingController < ApplicationController
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
    @user = User.find_by(params[:id])

    if (@user.id == current_user.id)
      flash[:notice] = "can't vote yourself"
      redirect_to root_path
    end
  end
end

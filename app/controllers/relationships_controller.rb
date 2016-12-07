class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user
  def create
    # @user = User.find(params[:id])
    current_user.follow(@user)
  end

  def destroy
    current_user.unfollow(@user)
  end

  private
  def check_user
    @user = User.find(params[:id])

   if (@user.id == current_user.id)
        flash[:success] = "you can't vote yourself!"
        redirect_to root_path
   end
  end


end

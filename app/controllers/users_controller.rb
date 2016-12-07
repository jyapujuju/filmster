class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    # @ref = Relationship.where(follower_id: current_user.id)
    @user=User.find(params[:id])
  end
end

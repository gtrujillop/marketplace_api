module Api::V1
  class UsersController < BaseController
    def show
      @user = current_user
      render json: @user, status: :ok
    end
  end
end

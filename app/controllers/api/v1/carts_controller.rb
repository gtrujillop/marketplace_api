module Api::V1
  class CartsController < BaseController
    before_action :authenticate_user_from_token!

    def create
      @cart = Cart.create(user: current_user, state: :collecting)
      if @cart.process(params)
        render json: @cart, status: :ok
      else
        @cart.destroy
        render json: { error: 'Unable to create cart. Please verify and try to purchase again.' }, status: :unprocessable_entity
      end
    end
  end
end

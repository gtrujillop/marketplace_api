module Api::V1
  class CartsController < BaseController
    before_action :authenticate_user_from_token!

    def create
      @cart = Cart.new(user: current_user)
      if @cart.save
        render json: @cart, status: :ok
      else
        render json: 'Unable to create cart', status: :unprocessable_entity
      end
    end

    def update
      @cart = Cart.find(cart_params[:cart_id])
      render json: 'Cart not found', status: :not_found unless @cart
      render json: 'Cart updated.' if @cart.process(cart_params)
    end

    def destroy
      #code
    end

    private

    def cart_params
      params.require(:cart).permit(
        :product_id,
        :cart_id,
        :op_type
      )
    end
  end
end

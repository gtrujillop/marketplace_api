module Api::V1
  class ProductsController < BaseController
    before_action :authenticate_user_from_token!, except: [:index, :show]
    before_action :ensure_is_admin, only: [:create]

    def create
      Product.transaction do
        products_params.each do |product|
          Product.create(

          )
        end
      end
    end

    def products_params
      params.require(:products)
    end

  end
end

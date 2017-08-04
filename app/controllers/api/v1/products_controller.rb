module Api::V1
  class ProductsController < BaseController
    before_action :authenticate_user_from_token!, except: [:index, :show]
    before_action :ensure_is_admin, only: [:create]

    def create
      Product.transaction do
        products_params.each do |product|
          Product.create(
            name: product[:name],
            brand: product[:brand],
            model: product[:model],
            sku: product[:sku],
            desc: product[:desc],
            price_cents: product[:price] * 100
          )
        end
      end
      render json: Product.all, status: 200
    end

    def index
      @products = Product.all
      render json: @products, status: 200
    end

    def products_params
      params.require(:products)
    end

  end
end

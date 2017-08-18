module Api::V1
  class ProductsController < BaseController
    before_action :authenticate_user_from_token!, except: [:index, :show]
    before_action :ensure_is_admin, only: [:create]

    def create
      Product.transaction do
        products_params.each do |product|
          begin
            Product.create!(
              name: product[:name],
              brand: product[:brand],
              model: product[:model],
              sku: product[:sku],
              desc: product[:desc],
              price_cents: product[:price].to_i * 100
            )
          rescue => e
            raise ActiveRecord::RecordNotSaved.new(message: "Products were not created due to \n" + e.message)
          end
        end
      end
      render json: Product.all, status: :ok
    end

    def index
      @products = Product.all
      render json: @products, status: 200
    end

    def show
      @product = Product.find(params[:id])
      if @product
        render json: @product, status: 200
      else
        render json: { error: 'Product not found' }, status: 404
      end
    end

    def products_params
      params.require(:products)
    end

  end
end

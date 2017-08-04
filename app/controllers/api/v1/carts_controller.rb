module Api::V1
  class CartsController < BaseController
    before_action :authenticate_user_from_token!, except: [:create]

    def create
      #code
    end

    def update
      #code
    end

    def destroy
      #code
    end
  end
end

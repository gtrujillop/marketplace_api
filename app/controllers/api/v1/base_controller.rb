module Api::V1
  class BaseController < ApplicationController
    skip_before_action :authenticate_user!

    def ensure_is_admin
      unless current_user && current_user.is_admin?
        raise UnauthorizedError.new("Access denied for this user #{current_user.email}")
      end
    end

  end
end

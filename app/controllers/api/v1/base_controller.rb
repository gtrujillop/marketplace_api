module Api::V1
  class BaseController < ApplicationController
    skip_before_action :authenticate_user!
  end
end

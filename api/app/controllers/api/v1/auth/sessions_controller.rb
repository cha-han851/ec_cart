# frozen_string_literal: true

module Api::V1
  class Auth::SessionsController < DeviseTokenAuth::SessionsController  
    before_action :sign_in_params, only: :create

    private

    def sign_in_params
      params.permit(:email, :password, :session, :headers)
    end
  end
end

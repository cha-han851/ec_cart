# frozen_string_literal: true

module Api::V1
  class Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController    
    private

    def sign_up_params
      params.require(:registration)
            .permit(:first_name, :last_name, :email, :phone, :zip, :address_one,
                    :address_two, :address_three, :password, :password_confirmation)
    end

    def account_update_params
      params.permit(:first_name, :last_name, :email, :phone)
    end
  end
end

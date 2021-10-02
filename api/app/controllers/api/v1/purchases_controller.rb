# frozen_string_literal: true

class Api::V1::PurchasesController < ApplicationController
  before_action :create_params, only: :create

  # POST /api/v1/purchases
  def create
    response = Purchase.generate_purchase(params)
    render json: response
  end

  private

  def create_params
    params.require(:purchase).permit(:purchase_history, :account_id, :products, :delivery)
  end
end

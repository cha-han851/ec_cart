# frozen_string_literal: true

class Api::V1::PurchaseHistoriesController < ApplicationController
  before_action :set_purchase_history, only: :show

  # GET /api/v1/purchase_histories
  def index
    response = PurchaseHistory.all
    render json: response
  end

  # GET /api/v1/purchase_histories/:id
  def show
    render json: @purchase_history
  end

  # DELETE /api/v1/purchase_histories/:id
  def destroy
    @purchase_history.destroy!
    render status: 200, json: { status: 200, result: 'ok' }
  end

  private

  def set_purchase_history
    @purchase_history ||= PurchaseHistory.find(params[:id])
  end
end

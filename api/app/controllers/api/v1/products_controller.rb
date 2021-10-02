# frozen_string_literal: true

class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  before_action :create_params, only: :create

  # GET /api/v1/products
  def index
    response = Product.includes(:category).displayable
    render json: response
  end

  # POST /api/v1/products
  def create
    response = Product.generate_product(params)
    render json: response
  end

  # GET /api/v1/products/:id
  def show
    render json: @product, status: 200, result: :ok
  end

  # PUT /api/v1/products/:id
  # def update
  #   @product
  #   render json: response
  # end

  # DELETE /api/v1/products/:id
  def destroy
    if @product.destroy
      render json: { status: 200, result: :ok }
    else
      render json: { status: 500, result: :error }
    end
  end

  private

  def set_product
    @product ||= Product.find(params[:id])
  end

  def create_params
    params.require(:product).permit(:name, :description, :price, :stock, :category_id, :display_flag)
  end
end

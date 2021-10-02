# frozen_string_literal: true

class Purchase < ApplicationRecord
  include ActiveModel::Model
  include ActiveModel::Attributes

  # FIXME: attributeの独自データ型を作成する
  
  class << self
    # FIXME: メソッドのリファクタリング
    def generate_purchase(params)
      account = Account.find(params[:account_id])
  
      delivery_params = params[:delivery]
      purchase_params = params[:purchase_history]
      products_params = params[:products]

      ActiveRecord::Base.transaction(joinable: false, requires_new: true) do
        # NOTE: Deliveryが既に存在する場合を考慮
        delivery = if delivery_params[:id].present?
                     Delivery.find(delivery_params[:id])
                   else
                     Delivery.new(
                       first_name: delivery_params[:first_name],
                       last_name: delivery_params[:last_name],
                       email: delivery_params[:email],
                       phone: delivery_params[:phone],
                       zip: delivery_params[:zip],
                       address_one: delivery_params[:address_one],
                       address_two: delivery_params[:address_two],
                       address_three: delivery_params[:address_three],
                     )
                   end
        delivery.save! if delivery_params[:id].blank?

        # 購入履歴
        purchase_history = delivery.purchase_histories.new(
          payment_type: purchase_params[:payment_type].to_i,
          delivery_type: purchase_params[:delivery_type].to_i,
          message: purchase_params[:message],
          total_price: purchase_params[:total_price].to_i,
          account_id: account.id,
        )
        purchase_history.save!
  
        products_params.map do |product_param|
          # NOTE: productが存在しない場合は例外処理で捕捉
          product = Product.find(product_param[:id])
  
          exact_total_price = product.price * product_param[:total_count].to_i
          
          if product_param[:total_price].to_i == exact_total_price
            purchase_product = purchase_history.purchase_products.new(
              total_count: product_param[:total_count].to_i,
              total_price: product_param[:total_price].to_i,
              product_id: product.id,
            )
            purchase_product.save!
          else
            # NOTE: 小計価格が一致しない場合はRollback
            error_message = "total_price #{product_param[:total_price]} is wrong"
            Rails.logger.error "[ERROR]: #{error_message}"
            raise error_message
          end
        end
      end
      Rails.logger.info "[INFO] purchase succeed"
      response = {
        result: 'ok',
        status: 200,
        message: 'purchase succeed',
        account_id: account.id,
      }
    rescue => e
      Rails.logger.error "[ERROR] purchase failed. account_id: #{account.id}"
      Rails.logger.error "[ERROR] #{e.message}"
      response = {
        result: 'error',
        status: 500,
        message: e.message,
        account_id: account.id,
      }
    end
  end
end

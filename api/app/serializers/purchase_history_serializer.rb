# frozen_string_literal: true

class PurchaseHistorySerializer < ActiveModel::Serializer
  attributes :id,
             :shipping_type,
             :shipping_status,
             :payment_type,
             :payment_status,
             :message,
             :total_price,
             :created_at,
             :updated_at,
             :account_id,
             :delivery_id
end

# frozen_string_literal: true

class PurchaseProductSerializer < ActiveModel::Serializer
  attributes :id,
             :total_count,
             :total_price,
             :created_at,
             :updated_at,
             :purchase_history_id,
             :product_id
end

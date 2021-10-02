# frozen_string_literal: true

class DeliverySerializer < ActiveModel::Serializer
  attributes :id,
             :first_name,
             :last_name,
             :email,
             :phone,
             :zip,
             :address_one,
             :address_two,
             :address_three,
             :created_at,
             :updated_at
end

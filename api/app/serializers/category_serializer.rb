# frozen_string_literal: true

class CategorySerializer < ActiveModel::Serializer
  # has_many :products

  attributes :id,
             :name,
             :serial_prefix,
             :description,
             :created_at,
             :updated_at
end

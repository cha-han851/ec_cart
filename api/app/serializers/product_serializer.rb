# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  # belongs_to :category

  attributes :id,
             :name,
             :description,
             :price,
             :category_id,
             :serial_number,
             :stock,
             :display_flag,
             :main_image_url,
             :main_image_alt,
             :created_at,
             :updated_at
end

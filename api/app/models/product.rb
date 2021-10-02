# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category

  has_many :purchase_histories, through: :purchase_products
  has_many :purchase_products

  attribute :id, :integer
  attribute :name, :string
  attribute :description, :string
  attribute :price, :integer
  attribute :category_id, :integer
  attribute :serial_number, :string
  attribute :stock, :integer
  attribute :display_flag, :integer
  attribute :created_at, :datetime
  attribute :updated_at, :datetime

  # serial_numberのフォーマット
  VALID_SERIAL_NUMBER_FORMAT = /[A-Z]{3}-[0-9]{6}/

  enum display_flag: [
    :private_status,
    :public_status,
  ]

  validates :name,
             presence: true
  validates :price,
             presence: true,
             numericality: true
  validates :serial_number,
             presence: true,
             uniqueness: true,
             length: { is: 10 },
             format: { with: VALID_SERIAL_NUMBER_FORMAT }
  validates :stock,
             presence: true,
             numericality: true
  validates :display_flag,
             presence: true,
             inclusion: {in: Product.display_flags.keys}

  scope :displayable, -> { where(display_flag: true) }

  # product生成
  class << self
    def generate_product(params)
      category = Category.find(params[:category_id])
      # serial_number生成
      product_count = Product.where(category_id: category.id).count + 1
      serial_number = "#{category.serial_prefix}-#{sprintf('%06d', product_count)}"

      category.products.create!(
        name: params[:name],
        description: params[:description],
        price: params[:price],
        serial_number: serial_number,
        stock: params[:stock],
        display_flag: params[:display_flag],
        main_image_url: params[:main_image_url],
      )
    end
  end
end

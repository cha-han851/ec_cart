# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  attribute :id, :integer
  attribute :name, :string
  attribute :serial_prefix, :string
  attribute :description, :string
  attribute :created_at, :datetime
  attribute :updated_at, :datetime

  # serial_prefixのフォーマット
  VALID_SERIAL_PREFIX_FORMAT = /[A-Z]{3}/

  validates :name, presence: true
  validates :serial_prefix, presence: true, uniqueness: true,
             length: { is: 3 }, format: { with: VALID_SERIAL_PREFIX_FORMAT }

  # category生成
  def self.generate_category(params)
    # serial_prefix生成
    last_category = Category.order(id: :asc).last
    serial_prefix = if last_category.present?
                      last_category.serial_prefix.succ
                    else
                      'AAA'
                    end

    Category.create!(
      name: params[:name],
      serial_prefix: serial_prefix,
      description: params[:description],
    )
  end
end

# frozen_string_literal: true

class PurchaseHistory < ApplicationRecord
  belongs_to :account
  belongs_to :delivery

  has_many :products, through: :purchase_products, dependent: :destroy
  has_many :purchase_products, dependent: :destroy

  enum delivery_type: [
    :cash_on_delivery,
    :credit_card,
  ]

  enum payment_type: [
    :delivery,
    :delivery_box,
    :convenience_store,
  ]

  validates :delivery_type,
             presence: true,
             inclusion: {in: PurchaseHistory.delivery_types.keys}
  validates :payment_type,
             presence: true,
             inclusion: {in: PurchaseHistory.payment_types.keys}
  validates :total_price,
             presence: true
end

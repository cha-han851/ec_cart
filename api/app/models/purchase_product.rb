# frozen_string_literal: true

class PurchaseProduct < ApplicationRecord
  belongs_to :purchase_history
  belongs_to :product

  validates :total_count, presence: true
  validates :total_price, presence: true
end

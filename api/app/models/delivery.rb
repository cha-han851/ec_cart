# frozen_string_literal: true

class Delivery < ApplicationRecord
  has_many :purchase_histories

  attribute :id, :integer
  attribute :first_name, :string
  attribute :last_name, :string
  attribute :email, :string
  attribute :phone, :string
  attribute :zip, :string
  attribute :address_one, :string
  attribute :address_two, :string
  attribute :address_three, :string
  attribute :created_at, :datetime
  attribute :updated_at, :datetime

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  VALID_ZIP_REGEX = /\A\d{7}\z/

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
             presence: true,
             uniqueness: { case_sensitive: true },
             format: { with: VALID_EMAIL_REGEX }
  validates :phone,
             presence: true,
             uniqueness: { case_sensitive: true },
             length: { in: 10..11 },
             format: { with: VALID_PHONE_REGEX }
  validates :zip,
             presence: true,
             length: { is: 7 },
             format: { with: VALID_ZIP_REGEX }
  validates :address_one, presence: true
  validates :address_two, presence: true
end

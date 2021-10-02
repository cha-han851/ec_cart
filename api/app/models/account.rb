# frozen_string_literal: true

class Account < ActiveRecord::Base
  has_many :purchase_histories

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

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

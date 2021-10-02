# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    id { 1 }
    name { 'テスト商品1' }
    description { 'これはテスト商品1です' }
    price { 1300 }
    stock { 15 }
    serial_number { 'AAA-000001' }
    category_id { 1 }
    display_flag { 1 }
    created_at { '2021-01-01 00:00:00' }
    updated_at { '2021-01-01 00:00:00' }
  end
end
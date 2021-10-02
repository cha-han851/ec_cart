# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    id { 1 }
    name { 'テストカテゴリー1' }
    serial_prefix { 'AAA' }
    description { 'これはテストカテゴリー1です' }
    created_at { '2021-01-01 00:00:00' }
    updated_at { '2021-01-01 00:00:00' }
  end
end
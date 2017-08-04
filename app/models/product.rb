# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  brand       :string
#  model       :string
#  sku         :string
#  price_cents :integer
#  desc        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ApplicationRecord
  validates :name, :brand, :model, :sku, presence: true
  validates :sku, uniqueness: true
  validates :price_cents, numericality: true, presence: true
end

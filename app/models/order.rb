# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  state       :integer
#  cart_id     :integer
#  total_cents :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Order < ApplicationRecord
  belongs_to :cart
  has_one :address, as: :addressable
  has_many :order_items, dependent: :destroy
end

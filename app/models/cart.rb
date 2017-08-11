# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cart < ApplicationRecord
  belongs_to :user
  has_one :order, dependent: :destroy

  def process(params)
    create_order(params)
  end

  private

  def create_order(params)
    order = Order.create(
      cart: self,
      total_cents: 0,
      state: :created
    )
    order.create_order_items(params[:cart])
    return true if order.order_items.length == params[:cart].length
    return false
  end
end

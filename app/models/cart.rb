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
    create_order unless order
    if order
    end
  end

  private

  def create_order
    order = Order.create(
      cart: self,
      total_cents: 0,
      state: :created
    )
  end
end

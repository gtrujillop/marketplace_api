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
  has_one :address, as: :addressable, dependent: :destroy
  has_many :order_items, dependent: :destroy

  enum state: [:created, :collecting, :confirmed, :approved]

  delegate :user, to: :cart, prefix: true
  after_create :clone_address_from_cart_user

  def create_order_items(items)
    created_items = items.map do |item|
      OrderItem.create(
        order: self,
        product: Product.find(item[:id])
      )
    end
    self.state = :confirmed
    self.total_cents = created_items.map(&:product)
                                    .map(&:price_cents)
                                    .reduce(:+)
    save
  rescue StandardError => e
    puts e
  end

  private

    def clone_address_from_cart_user
      return unless cart_user && cart_user.address
      address = cart_user.address.clone
      address.addressable = self
      address.save
    end
end

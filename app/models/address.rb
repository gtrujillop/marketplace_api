# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  name             :string
#  address          :string
#  country          :string
#  city             :string
#  postal_code      :string
#  addressable_type :string
#  addressable_id   :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
end

class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :address
      t.string :country
      t.string :city
      t.string :postal_code
      t.references :addressable, polymorphic: true, index: true
      t.timestamps
    end
  end
end

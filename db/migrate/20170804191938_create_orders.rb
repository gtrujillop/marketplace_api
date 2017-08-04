class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :state
      t.references :cart, foreign_key: true
      t.integer :total_cents

      t.timestamps
    end
  end
end

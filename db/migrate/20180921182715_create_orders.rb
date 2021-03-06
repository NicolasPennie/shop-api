class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.text :comment
      t.decimal :cost
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end

class CreateShipments < ActiveRecord::Migration[5.0]
  def change
    create_table :shipments do |t|
      t.references :purchases, foreign_key: true

      t.timestamps
    end
  end
end

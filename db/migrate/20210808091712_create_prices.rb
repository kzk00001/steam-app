class CreatePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :prices do |t|
      t.integer :game_purchase_price
      t.string :discount_pct
      t.string :discount_original_price
      t.string :discount_final_price
      t.references :applist,         null: false, foreign_key: true
      t.timestamps
    end
  end
end

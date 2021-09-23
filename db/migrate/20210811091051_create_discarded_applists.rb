class CreateDiscardedApplists < ActiveRecord::Migration[6.0]
  def change
    create_table :discarded_applists do |t|
      t.integer :appid,      null: false
      t.string :name,       null: false
      t.datetime :release_date
      t.integer :game_purchase_price
      t.string :review_summary
      t.timestamps
    end
  end
end

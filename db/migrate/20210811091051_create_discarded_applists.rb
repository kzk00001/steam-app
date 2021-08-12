class CreateDiscardedApplists < ActiveRecord::Migration[6.0]
  def change
    create_table :discarded_applists do |t|
      t.string :appid,      null: false
      t.string :name,       null: false
      t.string :release_date
      t.string :price
      t.string :review_summary
      t.timestamps
    end
  end
end

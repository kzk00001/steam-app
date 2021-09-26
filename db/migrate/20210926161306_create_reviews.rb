class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :review_summary,      null: false
      t.integer :rating
      t.references :applist,         null: false, foreign_key: true
      t.timestamps
    end
  end
end

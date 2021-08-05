class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.text :header_image_url,               null: false
      t.text :description,               null: false
      t.string :review_summary,               null: false
      t.string :release_date,               null: false
      t.string :developer,               null: false
      t.timestamps
    end
  end
end

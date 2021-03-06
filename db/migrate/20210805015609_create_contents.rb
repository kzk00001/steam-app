class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.text :header_image_url,      null: false
      t.text :glance_detail

      t.text :description
      t.datetime :release_date
      t.string :developer
      t.references :applist,         null: false, foreign_key: true
      t.timestamps
    end
  end
end

class CreateScreenshotHds < ActiveRecord::Migration[6.0]
  def change
    create_table :screenshot_hds do |t|
      t.text :url,      null: false
      t.references :applist,     null: false, foreign_key: true
      t.timestamps
    end
  end
end

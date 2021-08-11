class CreateScreenshotMiddles < ActiveRecord::Migration[6.0]
  def change
    create_table :screenshot_middles do |t|
      t.text :url
      t.references :applist,     null: false, foreign_key: true
      t.timestamps
    end
  end
end

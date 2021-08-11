class CreateScreenshotPoors < ActiveRecord::Migration[6.0]
  def change
    create_table :screenshot_poors do |t|
      t.text :url,      null: false
      t.references :applist,     null: false, foreign_key: true
      t.timestamps
    end
  end
end

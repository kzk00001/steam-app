class CreateScreenshotHds < ActiveRecord::Migration[6.0]
  def change
    create_table :screenshot_hds do |t|
      t.text :screenshot_hd_url,               null: false
      t.timestamps
    end
  end
end

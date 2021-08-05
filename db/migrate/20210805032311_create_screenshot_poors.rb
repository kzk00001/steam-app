class CreateScreenshotPoors < ActiveRecord::Migration[6.0]
  def change
    create_table :screenshot_poors do |t|
      t.text :screenshot_poor_url,               null: false
      t.timestamps
    end
  end
end

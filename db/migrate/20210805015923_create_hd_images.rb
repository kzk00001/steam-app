class CreateHdImages < ActiveRecord::Migration[6.0]
  def change
    create_table :hd_images do |t|

      t.timestamps
    end
  end
end

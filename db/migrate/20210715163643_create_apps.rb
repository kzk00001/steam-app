class CreateApps < ActiveRecord::Migration[6.0]
  def change
    create_table :apps do |t|
      t.string :appid, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end

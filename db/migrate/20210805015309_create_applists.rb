class CreateApplists < ActiveRecord::Migration[6.0]
  def change
    create_table :applists do |t|
      t.integer :appid,      null: false
      t.string :name,       null: false
      t.timestamps
    end
  end
end

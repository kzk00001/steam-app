class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.string :name,               null: false
      t.string :price,               null: false
      t.string :sale,               null: false
      t.string :review,               null: false
      t.string :release,               null: false
      t.string :page,               null: false
      t.string :header,               null: false
      t.timestamps
    end
  end
end

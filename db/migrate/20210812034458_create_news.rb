class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :news do |t|
      t.string :title,     null: false
      t.text :url,     null: false
      t.string :author
      t.text :contents
      t.string :date
      t.references :applist,     null: false, foreign_key: true
      t.timestamps
    end
  end
end

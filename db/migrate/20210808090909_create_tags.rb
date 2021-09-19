class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :name,      null: false
      t.string :record_num
      t.timestamps
    end
  end
end

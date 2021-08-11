class CreateApplistTags < ActiveRecord::Migration[6.0]
  def change
    create_table :applist_tags do |t|
      t.references :applist,         null: false, foreign_key: true
      t.references :tag,             null: false, foreign_key: true
      t.timestamps
    end
  end
end

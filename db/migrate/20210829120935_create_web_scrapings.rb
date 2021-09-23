class CreateWebScrapings < ActiveRecord::Migration[6.0]
  def change
    create_table :web_scrapings do |t|
      t.integer :applists_length
      t.integer :scraped_num
      t.timestamps
    end
  end
end

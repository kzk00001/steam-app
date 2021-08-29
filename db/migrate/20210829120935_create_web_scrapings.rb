class CreateWebScrapings < ActiveRecord::Migration[6.0]
  def change
    create_table :web_scrapings do |t|
      t.string :applists_length
      t.string :scraped_num
      t.timestamps
    end
  end
end

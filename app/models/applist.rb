class Applist < ApplicationRecord
  has_one :content,             dependent: :destroy
  has_many :screenshot_hd,      dependent: :destroy
  has_many :screenshot_middle,  dependent: :destroy
  has_many :screenshot_poor,    dependent: :destroy
  has_many :movie,              dependent: :destroy
  has_many :price,              dependent: :destroy

  has_many :applist_tags
  has_many :tags, through: :applist_tags
end

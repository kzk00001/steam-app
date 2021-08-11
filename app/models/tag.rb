class Tag < ApplicationRecord
  has_many :applist_tags,              dependent: :destroy
  has_many :applists, through: :applist_tags
end
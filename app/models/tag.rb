class Tag < ApplicationRecord
  has_many :applist_tags
  has_many :applists, through: :applist_tags
end
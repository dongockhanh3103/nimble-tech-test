class SearchResult < ApplicationRecord
  validates_presence_of :keyword

  belongs_to :user
end

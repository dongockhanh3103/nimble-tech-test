class User < ApplicationRecord
  has_many :reports
  has_many :search_results
end

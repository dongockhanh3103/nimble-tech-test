class User < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 

  has_many :reports
  has_many :search_results
end

class UserReport < ApplicationRecord
  enum state: {
    initial:     0,
    in_progress: 1,
    success:     2,
    failed:      3,
  }

  serialize :criteria, JSON
  belongs_to :user

  mount_uploader :file, SReport::ReportDeliver::ReportUploader

  # Gets the permission report url
  def report_url
    return '' if file.nil?
  
    "#{Settings.hostname}/files/report?id=#{id}"
  end
end

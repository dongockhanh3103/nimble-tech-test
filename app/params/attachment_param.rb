class AttachmentParam < BaseParam
  MAX_KEY_WORD = 100
  require 'csv'

  def initialize(file)
    @file = file
  end

  def validate
    errors = []
    rows = []

    if @file.blank?
      errors << 'CSV file is empty'
      return { errors: errors }
    end

    CSV.foreach(@file.path) do |keyword|
      rows << keyword.first
    end

    errors << "Size of keyword must be less than #{MAX_KEY_WORD} and more than 1" if rows.size > MAX_KEY_WORD || rows.size < 1

    { errors: errors, file: rows }
  end
end
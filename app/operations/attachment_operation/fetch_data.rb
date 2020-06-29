module AttachmentOperation
  class FetchData < BaseOperation

    def initialize(csv, user)
      @file = csv[:file]
      @user = user
    end

    def execute
      @file.each { |keyword| FetchSearchResult.perform_async(keyword, @user.id) }
  
      { success: true }
    rescue StandardError => exeption
      Rails.logger.debug(exeption)

      { success: false }
    end

  end
end
module Attachment
  class FetchDataOperation < BaseOperation

    def initialize(csv, user)
      @csv = csv
      @file = csv[:file]
      @user = user
    end

    def execute
      search_results = []

      @file.each do |keyword|
        result = Google::StatisticSearchService.new(keyword).execute
        search_results << SearchResultOperation::CreateSearchResult.execute(keyword: keyword,result: result,user: @user)
      end

      ReportServices::GoogleSearch::Report.new.generate(@user.id, search_results)

      { success: true }
    rescue StandardError => exeption
      Rails.logger.debug(exeption)

      { success: false }
    end

  end
end
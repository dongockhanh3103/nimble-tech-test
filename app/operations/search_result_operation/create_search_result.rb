module SearchResultOperation
  class CreateSearchResult < BaseOperation
    def initialize(keyword:, result:, user:)
      @keyword = keyword
      @result = result
      @user = user
    end

    def execute
      result = SearchResult.create!(
        keyword: @keyword,
        total_ad_word: @result['totalAdwords'] || 0,
        total_link: @result['totalLinks'] || 0,
        total_result: @result['totalResults'] || 0,
        html_content: @result['htmlContent'],
        search_time: @result['searchTime'],
        user_id: @user.id || 1
      )

      result
    rescue StandardError => error
      p error
      nil
    end
  end
end
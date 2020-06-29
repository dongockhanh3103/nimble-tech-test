# frozen_string_literal: true

class FetchSearchResult
  include Sidekiq::Worker

  def perform(keyword, user_id)
    result = Google::StatisticSearchService.new(keyword).execute

    SearchResultOperation::CreateSearchResult.execute(keyword: keyword, result: result, user_id: user_id )
  end

end
module SearchResultOperation
  class GetSearchResults < BaseOperation
    def initialize(user_id)
      @user_id = user_id
    end

    def execute
      SearchResult.where(user_id: @user_id).order(keyword: :desc)
    rescue StandardError => error
      p error
      nil
    end
  end
end
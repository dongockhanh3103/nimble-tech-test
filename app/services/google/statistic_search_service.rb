module Google
  class StatisticSearchService < Google::BaseSearchService

    def options
      { num: 10, filter: 1 }
    end

    def search_fields
      ['totalResults', 'searchTime']
    end

  end
end
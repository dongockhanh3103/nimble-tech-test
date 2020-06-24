# frozen_string_literal: true

module Google
  class BaseSearchService

    API_KEY = Settings.google.api_key
    CUSTOM_SEARCH_URL = Settings.google.custom_search_url
    SEARCH_CONTEXT = Settings.google.search_context

    def initialize(keyword)
      @keyword = keyword
    end

    def execute
      raise ArgumentError, 'the keyword must be not null' if @keyword.blank?

      response = Typhoeus.get(build_query(@keyword))

      get_score(response)
    end

    def options
      raise NotImplementedError, 'options'
    end

    def search_fields
      raise NotImplementedError, 'search_fields'
    end

    private

    def get_score(object)
      results = {}
      search_fields.each do |field|
        results[field] = HashUtil.nested_value(JSON.parse(object.response_body), field)
      end

      results
    end

    def build_query(keyword)
      "#{CUSTOM_SEARCH_URL}?key=#{API_KEY}&cx=#{SEARCH_CONTEXT}&q=#{keyword}&#{build_options()}"
    end

    def build_options()
      queries = []
      options().each { |k,v| queries << "#{k.to_s}=#{v}" }

      queries.join('&')
    end

  end
end
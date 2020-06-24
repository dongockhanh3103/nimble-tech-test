module ReportServices
  module GoogleSearch
    class Report < SReport::SynchronousBaseReport

      def basename
        'gooogle_search_result_report'
      end

      def self.report_config
        @report_config ||= SReport::ReportConfig.new({
          column_keys_header: {
            keyword: 'Keyword',
            total_results: 'Total Results',
            total_adwords: 'Total Adwords',
            search_time: 'Search Time'
          }
        })
      end

      def generate_data(params)
        params.map do |search_result|
          {
            keyword: search_result.keyword,
            total_results: search_result&.total_result,
            total_adwords: search_result&.total_ad_word,
            search_time: search_result&.search_time
          }
        end
      end
      
    end
  end
end
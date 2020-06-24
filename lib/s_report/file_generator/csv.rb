require 'csv'

module SReport
  module FileGenerator
    module Csv

      DEFAULT_IO_MODE = 'wb'

      class << self

        # @param file_path [String]           The filepath of report
        # @param report_data [Array<Object>]  The content data of the report
        # @param report_config [ReportConfig] The report config including: heading values and column keys
        #
        # @return [CSV] The CSV report file
        def write(file_path, report_data, report_config, is_show_header = true)
          CSV.open(file_path, 'wb') do |csv|
            if is_show_header
              csv << report_config.get_headers
            end

            (report_data || []).each do |item|
              columns = report_config.get_column_keys
              row = columns.map { |column| item[column] }
              csv << row
            end
          end
        end

        def generate_file_name(base_name)
          "#{base_name}.#{file_extension}"
        end

        def file_extension
          "csv"
        end

        # Combine multiple partial reports file to a final report file
        #
        # @param report_configs [Hash]
        # @param final_file_path [String] path of final report file
        # @param partial_file_urls [Array<String>] a list of partial report file urls
        def combine_file(report_configs, final_file_path, partial_report_file_urls)
          require 'open-uri'

          headers = report_configs.get_headers
          File.open(final_file_path, 'wb') do |final_file|
            final_file.puts headers.join(',')

            # Using simple merge strategy that read each file and concat it to final one
            partial_report_file_urls.each do |url|
              open(url) do |partial_file|
                partial_file.each_line { |line| final_file.puts line }
              end
            end
          end
        end

      end
    end
  end
end
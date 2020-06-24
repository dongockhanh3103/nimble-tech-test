module SReport
  class ReportConfig

    # @param column_key_header [Hash<String>] a hash between column key and its header
    # @param column_keys [Array<String>]
    def initialize(column_keys_header: {}, column_keys: [])
      # TODO: validation

      @column_keys_header = column_keys_header
      @column_keys = column_keys
    end

    def get_headers
      @column_keys_header ? @column_keys_header.values : []
    end

    def get_column_keys
      @column_keys.present? ? @column_keys : @column_keys_header.keys
    end
  end
end
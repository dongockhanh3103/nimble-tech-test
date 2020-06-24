
module Authz
  class UnauthorizedError < StandardError

    attr_reader :error_codes

    def initialize(error_codes = [])
      super
      @error_codes = error_codes
    end

  end
end

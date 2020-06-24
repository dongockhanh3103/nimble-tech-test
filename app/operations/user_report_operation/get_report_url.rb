# frozen_string_literal: true

module UserReportOperation
  class GetReportUrl < BaseOperation

    # @param [Integer] user_report_id The user report id
    # @param [Integer] user_id        The user has generated report
    def initialize(user_report_id, user_id)
      @user_report_id = user_report_id
      @user_id        = user_id
    end

    # Gets the report url from User report
    #
    # @return [String] The url of charity file
    def execute
      UserReport.where(
        id:      @user_report_id,
        user_id: @user_id
      ).first&.file&.url
    end

  end
end

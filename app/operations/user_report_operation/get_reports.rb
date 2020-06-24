module UserReportOperation
  class GetReports < BaseOperation

    def initialize(user_id)
      @user_id = user_id
    end

    def execute
      UserReport.select(:user_id, :file).where(user_id: @user_id, state: UserReport.states[:success])
    end

  end
end
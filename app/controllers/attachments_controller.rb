
class AttachmentsController < ApplicationController
  def index
    @errors = []
    @report = []
  end

  def upload
    @errors = []
    attachment_param = AttachmentParam.new(params[:file]).validate

    if(attachment_param[:errors].present?)
      @errors = attachment_param[:errors]
      return render :index
    end
    
    result = AttachmentOperation::FetchData.execute(attachment_param, current_user)
  
    if(result[:success])
      GenerateReports.perform_async(current_user.id)
    else
      @errors << 'Something when wrong!!!'
    end

    render :index
  end

  def generate_report
    search_results = SearchResultOperation::GetSearchResults.execute(current_user.id)
    ReportServices::GoogleSearch::Report.new.generate(current_user.id, search_results)
  
    result = UserReportOperation::GetReports.execute(current_user.id)
    @reports = result.map { |report| ReportPresenter.new(report) }

    render :index
  end

end

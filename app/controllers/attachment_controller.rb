
class AttachmentController < ApplicationController
  def index
    @errors = []
    @report = []
  end

  def upload
    @errors = []
    attachment_param = AttachmentParam.new(params[:file]).validate

    if(attachment_param[:errors].present?)
      @errors = attachment_param[:errors]
      return render(:index)
    end
    
    result = Attachment::FetchDataOperation.execute(attachment_param, current_user)
  
    if(result[:success])
      @reports = UserReportOperation::GetReports.execute(current_user.id)
    else
      @errors << 'Something when wrong!!!'
    end
    render(:index)
  end

  private
end

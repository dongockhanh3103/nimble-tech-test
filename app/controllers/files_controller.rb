class FilesController < ApplicationController
  require 'uri'

  def report
    url = UserReportOperation::GetReportUrl.execute(params[:id], current_user.id)

    view_file_from_url(url)
  end

  private

  def view_file_from_url(url)
    return redirect_to '/404' if url.blank?

    parse_url = URI.parse(url)
    data_file = parse_url.open
    file_name = File.basename(parse_url.path)

    send_data data_file.read,
              filename:    file_name,
              type:        data_file.content_type,
              disposition: :attachment,
              stream:      true,
              x_sendfile:  true
  end

end

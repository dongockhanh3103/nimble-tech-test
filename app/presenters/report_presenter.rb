class ReportPresenter

  def initialize(report)
    @report = report
  end

  def id
    @report.id
  end

  def url
    @report.file.url
  end

end
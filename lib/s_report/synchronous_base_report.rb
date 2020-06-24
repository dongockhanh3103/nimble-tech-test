module SReport
  class SynchronousBaseReport < BaseReport

    def generate(owner_id, params)
      rows = generate_data(params)
      file_name = "#{basename}.#{self.class.file_generator.file_extension}"
      tempfile = Tempfile.new(file_name)

      begin
        tempfile_path = tempfile.path

        user_report = create_user_report(params, owner_id)
        self.class.file_generator.write(tempfile_path, rows, report_config)

        user_report.update(
          file: tempfile,
          finishes_on: Time.now,
          state: UserReport.states[:success]
        )

        {
          report_type: user_report.report_type,
          report_status: user_report.state,
          report_url: user_report.report_url
        }
      ensure
        tempfile.close
        tempfile.unlink
      end
    end

    protected

    def generate_data(params)
      raise NotImplementedError
    end

  end
end
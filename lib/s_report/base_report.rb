module SReport
  class BaseReport

    def generate(params)
      raise NotImplementedError
    end

    def filename(basename)
      @file_generator.generate_filename(basename)
    end

    # Base name of report file, not including file extension
    def basename
      raise NotImplementedError
    end

    # The config for report file. It should include header and name of the column.
    # The column will be priority by order of attribute in the config
    def self.report_config
      raise NotImplementedError
    end

    def report_config
      self.class.report_config
    end

    def create_user_report(report_param, user_id)
      UserReport.create!(
        user_id: user_id,
        report_type: 'google',
        criteria: report_param,
        state: UserReport.states[:initial]
      )
    end

    protected

    def self.file_generator=(class_file_generator)
      @file_generator = class_file_generator
    end

    def self.file_generator
      @file_generator ||= SReport::FileGenerator::Csv
    end

     def self.get_partial_report_class
      self.module_parent.const_get(:PartialReport)
    end
  end
end
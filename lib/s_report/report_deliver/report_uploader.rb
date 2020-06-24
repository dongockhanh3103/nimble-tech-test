module SReport
  module ReportDeliver
    class ReportUploader < CarrierWave::Uploader::Base

      # Overrides the filename of the uploaded files
      def filename
        "user_report_#{model.id}.csv"
      end

      # Override the directory where uploaded files will be stored.
      def store_dir
        "reports/#{model.user_id}"
      end

      # Add a white list of extensions which are allowed to be uploaded.
      def extension_white_list
        %w[csv].freeze
      end
    end
  end
end
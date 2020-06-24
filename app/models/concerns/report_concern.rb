# frozen_string_literal: true

module ReportConcern

  extend ActiveSupport::Concern

  # @param extra_params [Hash]
  def generate_report(supported_report_types = Report::SUPPORTED_TYPES, extra_params = { })
    report_type = params.permit(:report_type)[:report_type]
    selected_report_type = supported_report_types.find { |type| type == report_type }

    return render_validation_errors('Report type is not valid') if selected_report_type.nil?

    report_class_name = selected_report_type.camelize
    report_param_class = "ReportServices::#{report_class_name}::Param".constantize
    report_service_class = "ReportServices::#{report_class_name}::Report".constantize

    param_attr_names = report_param_class.attributes.map(&:name)
    permitted_params = params.permit(param_attr_names)

    valid_params = validate_param!(
      report_param_class,
      permitted_params.merge(extra_params)
    )
    report_service_class.new.generate(current_user.id, valid_params)
  end

  def validate_resource_belong_to_owner
    charity_id_param = current_user.present? ? current_user.email : session[:user_email]

    if charity_id_param.present? && fundraiser_id.present?
      raise Authz::UnauthorizedError if
        Fundraiser.where(id: fundraiser_id, charity_id: charity_id_param).blank?
    end
  end

end

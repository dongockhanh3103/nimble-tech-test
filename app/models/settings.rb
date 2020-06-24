# frozen_string_literal: true

# Settings provides an easy to access configuration which is in config/application.yml.
#
# To access configuration, can use:
#   Settings.{key}
#   Settings.{key}.{nested_key}
class Settings < Settingslogic

  source "#{Rails.root}/config/application.yml"
  namespace Rails.env

end

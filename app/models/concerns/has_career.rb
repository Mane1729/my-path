require 'has_enum_attribute'

module HasCareer
  extend ActiveSupport::Concern
  extend HasEnumAttribute

  included do
    enum career: setup_enum_values(Career)
  end

  setup_enum_attributes :career, nillable: true
end
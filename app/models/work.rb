class Work < ActiveFedora::Base
  include Hydra::Works::WorkBehavior
  include Cul::Minicamp::LegacyProperties
  include Cul::Minicamp::CoreProperties
  contains "ocr", class_name: "GenericFile"
end

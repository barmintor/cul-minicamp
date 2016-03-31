class Work < ActiveFedora::Base
  include CurationConcerns::WorkBehavior
  include Cul::Minicamp::LegacyProperties
  include Cul::Minicamp::CoreProperties
  contains "ocr", class_name: "GenericFile", autocreate: false
end

class Work < ActiveFedora::Base
  include Cul::Minicamp::LegacyProperties
  include Cul::Minicamp::CoreProperties
  contains "ocr", class_name: "ActiveFedora::File"
end

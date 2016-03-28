class Work < ActiveFedora::Base
  include Cul::Minicamp::LegacyProperties
  contains "descMetadata", class_name: "ActiveFedora::File"
  contains "ocr", class_name: "ActiveFedora::File"
end

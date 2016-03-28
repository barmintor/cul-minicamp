class Work < ActiveFedora::Base
  contains "descMetadata", class_name: "ActiveFedora::File"
  contains "ocr", class_name: "ActiveFedora::File"
end

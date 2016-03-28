class Collection < ActiveFedora::Base
  contains "descMetadata", class_name: "ActiveFedora::File"
end

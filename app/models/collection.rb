class Collection < ActiveFedora::Base
  include Cul::Minicamp::LegacyProperties
  contains "descMetadata", class_name: "ActiveFedora::File"
end

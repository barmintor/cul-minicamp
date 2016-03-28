class GenericFile < ActiveFedora::Base
  include Cul::Minicamp::LegacyProperties
  contains "content", class_name: "ActiveFedora::File"
end

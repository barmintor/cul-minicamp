class GenericFile < ActiveFedora::Base
  include Hydra::Works::FileSetBehavior
  include Cul::Minicamp::LegacyProperties
  contains "content", class_name: "ActiveFedora::File"
end

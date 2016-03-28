class Collection < ActiveFedora::Base
  include Hydra::Works::CollectionBehavior
  include Cul::Minicamp::LegacyProperties
  include Cul::Minicamp::CoreProperties
end

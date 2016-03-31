class Collection < ActiveFedora::Base
  include CurationConcerns::CollectionBehavior
  include Cul::Minicamp::LegacyProperties
  include Cul::Minicamp::CoreProperties
end

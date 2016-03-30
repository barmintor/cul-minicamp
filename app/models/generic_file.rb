class GenericFile < ActiveFedora::Base
  include Hydra::Works::FileSetBehavior
  include Cul::Minicamp::LegacyProperties
  directly_contains_one :preservation_file, through: :files, type: ::RDF::URI('http://pcdm.org/use#PreservationMasterFile'), class_name: 'Hydra::PCDM::File'
  directly_contains_one :service_file, through: :files, type: ::RDF::URI('http://pcdm.org/use#ServiceFile'), class_name: 'Hydra::PCDM::File'
end

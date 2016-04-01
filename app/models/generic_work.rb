# Generated via
#  `rails generate curation_concerns:work GenericWork`
class GenericWork < ActiveFedora::Base
  include ::CurationConcerns::WorkBehavior
  include ::CurationConcerns::BasicMetadata
  include Sufia::WorkBehavior
  include Cul::Minicamp::LegacyProperties
  include Cul::Minicamp::CoreProperties
  contains "ocr", class_name: "FileSet", autocreate: false

  validates :title, presence: { message: 'Your work must have a title.' }
end

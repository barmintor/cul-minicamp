# Generated via
#  `rails generate curation_concerns:work ExampleWork`

class CurationConcerns::ExampleWorksController < ApplicationController
  include CurationConcerns::CurationConcernController
  set_curation_concern_type ExampleWork
end

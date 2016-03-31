require 'curation_concerns'
CurationConcerns.configure do |config|
  # Injected via `rails g curation_concerns:work ExampleWork`
  config.register_curation_concern :generic_file
  config.register_curation_concern :work
  config.register_curation_concern :collection
  config.enable_noids = false
end
CurationConcerns.config.enable_noids = false
class ActiveFedora::Base
  def assign_id(*args)
    id
  end
end
ActiveFedora::Base.translate_id_to_uri = lambda { |x| x }
ActiveFedora::Base.translate_uri_to_id = lambda { |x| x }
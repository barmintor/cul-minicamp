module Cul
  module Minicamp
    module LegacyProperties
      extend ActiveSupport::Concern
      included do
        self.property :legacy_pid, predicate: ActiveFedora::RDF::Fcrepo::Model.PID, multiple: false do |index|
          index.as :stored_sortable
        end
        self.property :state, predicate: ActiveFedora::RDF::Fcrepo::Model.state, multiple: false do |index|
          index.as :symbol, :facetable
        end
      end
    end
  end
end
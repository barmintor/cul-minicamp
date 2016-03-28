module Cul
  module Minicamp
    module CoreProperties
      extend ActiveSupport::Concern
      included do
        self.property :identifier, predicate: ::RDF::Vocab::DC.identifier do |index|
          index.as :symbol, :facetable
        end
        self.property :title, predicate: ::RDF::Vocab::DC.title do |index|
          index.as :stored_searchable, :facetable
        end
        self.property :creator, predicate: ::RDF::Vocab::DC.creator do |index|
          index.as :symbol, :facetable
        end
        self.property :created, predicate: ::RDF::Vocab::DC.created do |index|
          index.as :stored_sortable, type: :date
        end
        self.property :format, predicate: ::RDF::Vocab::DC.format do |index|
          index.as :stored_searchable, :facetable
        end
        self.property :object_type, predicate: ::RDF::Vocab::DC.type do |index|
          index.as :stored_searchable, :facetable
        end
        self.property :link, predicate: ::RDF::RDFS.seeAlso do |index|
          index.as :symbol, :facetable
        end
      end
    end
  end
end
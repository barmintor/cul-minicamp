module FedoraMigrate
  module Works
    class RelsExtDatastreamMover < FedoraMigrate::RelsExtDatastreamMover
      def missing_object?(statement)
        return false if ActiveFedora::Base.exists?(id_component(statement.object))
        report << "could not migrate relationship #{statement.predicate} because #{statement.object} doesn't exist in Fedora 4"
        true
      end
      # All the graph statements except hasModel, hasMember and those with missing objects
      def statements
        graph.statements.reject do |stmt|
          reject = (stmt.predicate == ActiveFedora::RDF::Fcrepo::Model.hasModel)
          reject ||= (stmt.predicate == Hydra::PCDM::Vocab::PCDMTerms.hasMember)
          reject ||= missing_object?(stmt)
        end
      end
    end
  end
end
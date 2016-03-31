module FedoraMigrate
  module Works
    class MembersMover < FedoraMigrate::Works::RelsExtDatastreamMover
      # All the graph statements indicating membership of existing objects
      def statements
        graph.statements.reject do |stmt|
          (stmt.predicate != Hydra::PCDM::Vocab::PCDMTerms.hasMember) || missing_object?(stmt)
        end
      end
      def migrate_object(fc3_uri)
        ActiveFedora::Base.find(id_component(fc3_uri))
      end
      def migrate_statements
        statements.each do |statement|
          triple = [target.rdf_subject, migrate_predicate(statement.predicate), statement.object]
          target.members << migrate_object(statement.object)
          report << triple.join("--")
        end
        target.save # so that we don't have an Etag mismatch on update_index
      end
    end
  end
end
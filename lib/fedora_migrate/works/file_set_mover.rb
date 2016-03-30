module FedoraMigrate
  module Works
    class FileSetMover < FedoraMigrate::ObjectMover
      ORIGINAL_FILE_DSID = 'content'
      PROVO_INVERSE = 'http://www.w3.org/ns/prov-o-inverses#'
      def pcdm_use_from_rels(rels_ext_ds)
        doc = Nokogiri::XML(rels_ext_ds.content)
        use = nil
        doc.xpath('//ns:qualifiedUsingActivity', ns: PROVO_INVERSE).each do |assertion|
          use = assertion['rdf:resource']
        end
        return RDF::URI(use) unless use.nil?
      end
      def migrate_content_datastreams
        super
        if target.is_a?(GenericFile) && source.datastreams[ORIGINAL_FILE_DSID]
          use = pcdm_use_from_rels(source.datastreams['RELS-EXT'])
          case use
          when "http://pcdm.org/use#PreservationMasterFile"
            original_file = target.build_preservation_file
          when "http://pcdm.org/use#ServiceFile"
            original_file = target.build_service_file
          else
            original_file = target.build_original_file
          end
          mover = FedoraMigrate::DatastreamMover.new(source.datastreams[ORIGINAL_FILE_DSID], original_file, options)
          target.original_file = original_file
          save
          report.content_datastreams << ContentDatastreamReport.new(ORIGINAL_FILE_DSID, mover.migrate)
        end
      end
    end
  end
end
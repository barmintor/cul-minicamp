module FedoraMigrate
  module Works
    class WorkMover < FedoraMigrate::Works::MappedObjectMover
      def migrate_datastreams
        migrate_content_datastreams
        migrate_ocr
        migrate_structure
        migrate_permissions
        migrate_dates
      end
      def migrate_ocr
        ds = source.datastreams['ocr']
        if ds && !ds.new?
          ocr_file_set = target.ocr
          ocr_file_set.apply_depositor_metadata('migrator') if target.respond_to? :apply_depositor_metadata
          ocr_file_set.edit_users = ['migrator']
          ocr_file_set.discover_user_groups = ['public'] if target.respond_to? :discover_user_groups
          ocr_file_set.read_user_groups = ['public'] if target.respond_to? :read_user_groups

          target.members << ocr_file_set
          target_file = ocr_file_set.build_extracted_text
          ocr_file_set.original_file = target_file
          mover = FedoraMigrate::DatastreamMover.new(ds, target_file, options)
          report.content_datastreams << ContentDatastreamReport.new(ds, mover.migrate)
        end
      end
      def migrate_structure
        ds = source.datastreams['structMetadata']
        if ds && !ds.new?
          mover = FedoraMigrate::Works::StructureMover.new(source, target, options)
          report.content_datastreams << ContentDatastreamReport.new(ds, mover.migrate)
        else
          FedoraMigrate::Works::MembersMover.new(source, target, options).migrate
        end
      end
    end
  end
end
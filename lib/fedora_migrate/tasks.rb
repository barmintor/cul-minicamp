module Fedora
  module Migrate
    module Tasks
      def self.pid_to_slug(pid)
        return nil if pid.nil?
        pid.split(':').last
      end
      def self.connection
        ActiveFedora.fedora.connection
      end
      def self.solr_connection
        ActiveFedora::SolrService.instance && ActiveFedora::SolrService.instance.conn
      end
      def self.delete_resource(resource)
        connection.delete(resource)
      rescue Ldp::Gone,Ldp::NotFound
      end
      def self.destroy_resource(resource)
        delete_resource(resource)
        delete_resource("#{resource}/fcr:tombstone")
        solr_connection.delete_by_query("id:\"#{resource}\"", params: { 'softCommit' => true }) unless solr_connection.nil?
      end
      def self.destroy_previously_migrated(pid, container=nil)
        prefix = ActiveFedora.config.credentials[:base_path]
        path_segs = [prefix, pid_to_slug(container), pid_to_slug(pid)].compact!
        resource = path_segs.join('/')
        resource.sub!(/^\//,'')
        destroy_resource(resource)
      end
      def self.migrate_common(pid, options = {}, mover_class=FedoraMigrate::ObjectMover)
        source = FedoraMigrate.source.connection.find(pid)
        target = nil
        mover = mover_class.new(source, target, options)
        mover.migrate
        target = mover.target
        FedoraMigrate::Works::RelsExtDatastreamMover.new(source, target, options).migrate
        nil
      end
      def self.migrate_administrative_set(pid, options={})
        destroy_previously_migrated(pid,options[:container]) if options[:reload]
        # do the migration
        migrate_common(pid, options)
      end
      def self.migrate_file_set(pid, options={})
        destroy_previously_migrated(pid,options[:container]) if options[:reload]
        # do the migration
        migrate_common(pid, options, FedoraMigrate::Works::FileSetMover)
      end
      def self.migrate_work(pid, options={})
        destroy_previously_migrated(pid,options[:container]) if options[:reload]
        # do the migration
        migrate_common(pid, options, FedoraMigrate::Works::WorkMover)
      end
      def self.migrate_collection(pid, options={})
        destroy_previously_migrated(pid,options[:container]) if options[:reload]
        # do the migration
        migrate_common(pid, options)
      end
    end
  end
end
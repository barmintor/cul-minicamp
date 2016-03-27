module FedoraMigrate::Hooks

  # @source is a Rubydora object
  # @target is a Hydra 9 modeled object

  # Called from FedoraMigrate::ObjectMover
  def before_object_migration
    # additional actions as needed
  end

  # Called from FedoraMigrate::ObjectMover
  def after_object_migration
    # additional actions as needed
  end

  # Called from FedoraMigrate::RDFDatastreamMover
  def before_rdf_datastream_migration
    # additional actions as needed
  end

  # Called from FedoraMigrate::RDFDatastreamMover
  def after_rdf_datastream_migration
    # additional actions as needed
  end

  # Called from FedoraMigrate::DatastreamMover
  def before_datastream_migration
    # additional actions as needed
  end

  # Called from FedoraMigrate::DatastreamMover
  def after_datastream_migration
    # additional actions as needed
  end

end

desc "Delete all the content in Fedora 4"
task clean: :environment do
  ActiveFedora::Cleaner.clean!
end
desc "Run my migrations"
task migrate: :environment do
  ## We're not going to use the namespace filtered repository migration for this workshop
  # report = FedoraMigrate.migrate_repository(namespace: "usna",options:{})
  subreports = []
  report = FedoraMigrate::MigrationReport.new
  subreports.each do {|subreport| report.results.merge! subreport.results }
  report.report_failures STDOUT
end
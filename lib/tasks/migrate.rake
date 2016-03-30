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
    if source.state
      case source.state
      when 'D'
        target.state = ActiveFedora::RDF::Fcrepo::Model.Deleted
      when 'I'
        target.state = ActiveFedora::RDF::Fcrepo::Model.Inactive
      else
        target.state = ActiveFedora::RDF::Fcrepo::Model.Active
      end
    end
    target.legacy_pid = source.pid
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

  # Called from FedoraMigrate::Works::StructureMover
  def before_structure_migration
    # additional actions as needed
  end

  # Called from FedoraMigrate::Works::StructureMover
  def after_structure_migration
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
  asset_map = YAML.load(open("#{Rails.root}/config/fixtures.yml"))
  assets = asset_map[:'1667751']
  subreports = []

  Hydra::Derivatives.fits_path = '/usr/local/fits/fits-0.6.2/fits.sh'
  assets[:generic_files].each do |pid|
    subreports << Fedora::Migrate::Tasks.migrate_file_set(pid, reload: true)
  end
  assets[:admin_sets].each do |pid|
    #subreports << Fedora::Migrate::Tasks.migrate_administrative_set(pid, reload: true)
  end
  assets[:pages].each do |pid|
    subreports << Fedora::Migrate::Tasks.migrate_work(pid, reload: true)
  end
  assets[:works].each do |pid|
    subreports << Fedora::Migrate::Tasks.migrate_work(pid, reload: true, convert: 'descMetadata')
  end
  assets[:collections].each do |pid|
    subreports << Fedora::Migrate::Tasks.migrate_collection(pid, reload: true, convert: 'descMetadata')
  end
  subreports.compact!
  report = FedoraMigrate::MigrationReport.new
  subreports.each {|subreport| report.results.merge! subreport.results }
  report.report_failures STDOUT
end
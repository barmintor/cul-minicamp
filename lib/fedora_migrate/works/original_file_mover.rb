require 'hydra/works/characterization'
module FedoraMigrate
  module Works
    class OriginalFileMover < FedoraMigrate::DatastreamMover
      def migrate_content(datastream=nil)
        datastream ||= source
        report << FedoraMigrate::Works::OriginalContentMover.new(datastream, target, options).migrate
      end
    end
  end
end
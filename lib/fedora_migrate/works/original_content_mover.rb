require 'tempfile'
module FedoraMigrate
  module Works
    class OriginalContentMover < FedoraMigrate::ContentMover
      def move_content
        target.content = options[:content] || source.content
        target.original_name = source.label.try(:gsub, /"/, '\"')
        target.mime_type = source.mimeType
        save
        report.error = "Failed checksum" unless valid?
      end
    end
  end
end
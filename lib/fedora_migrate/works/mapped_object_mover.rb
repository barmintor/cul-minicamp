module FedoraMigrate
  module Works
    class MappedObjectMover < FedoraMigrate::ObjectMover
      def target
        @target ||= FedoraMigrate::Works::MappedTargetConstructor.new(source).build
      end
    end
  end
end
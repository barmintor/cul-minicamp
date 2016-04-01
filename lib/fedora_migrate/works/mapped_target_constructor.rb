module FedoraMigrate
  module Works
    class MappedTargetConstructor < FedoraMigrate::TargetConstructor
      MODEL_MAP = {
        'GenericFile' => 'FileSet',
        'Work' => 'GenericWork'
      }

      def determine_target2
        Array(candidates).map { |model| vet(model) }.compact.first
      end

      def vet(model)
        orig_model = FedoraMigrate::Mover.id_component(model)
        mapped_model = MODEL_MAP.fetch(orig_model, nil)
        if mapped_model
          mapped_model.constantize
        else
          Logger.debug "rejecting #{model} for target (mapped to #{mapped_model}"
          nil
        end
      rescue NameError
        Logger.debug "rejecting #{model} for target (mapped to #{mapped_model}"
        nil
      end

      def candidates2
        @candidates ||= source.models
      end

    end
  end
end
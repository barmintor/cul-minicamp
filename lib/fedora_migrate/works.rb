module FedoraMigrate
  module Works
    autoload :FileSetMover, 'fedora_migrate/works/file_set_mover'
    autoload :StructureMover, 'fedora_migrate/works/structure_mover'
    autoload :WorkMover, 'fedora_migrate/works/work_mover'
  end
end
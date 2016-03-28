class GenericFile < ActiveFedora::Base
  contains "content", class_name: "ActiveFedora::File"
end

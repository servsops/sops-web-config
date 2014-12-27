
default_action :create

actions :create, :remove

attribute :name, :kind_of => String, :name_attribute => true, :required => true
attribute :attributes, :kind_of => Hash
attribute :source, :kind_of => String, :required => true

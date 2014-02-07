module Perfecta
  class ApiResource

    def meta_class
      class << self; self end
    end

    def initialize attrs
      attrs.each do |name, val|
        instance_variable_set "@#{name}", val

        meta_class.send(:define_method, name) do
          instance_variable_get "@#{name}"
        end

      end
    end
  end
end

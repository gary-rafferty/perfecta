module Perfecta
  class ApiResource
    def initialize attrs
      attrs.each do |name, val|
        instance_variable_set "@#{name}", val

        define_singleton_method name.to_sym do
          instance_variable_get "@#{name}"
        end
      end
    end
  end
end

module SimpleCrud
  module Accessors
    def model_klass
      self.class.model_klass
    end

    def model
      instance_variable_get model_var
    end

    def model!(value)
      instance_variable_set model_var, value
    end

    def model_name
      model_klass.to_s.underscore.downcase
    end

    def model_params
      send "#{model_name}_params"
    end

    def model_var
      "@#{model_name}"
    end

    def models
      instance_variable_get models_var
    end

    def models!(value)
      instance_variable_set models_var, value
    end

    def models_name
      model_name.pluralize
    end

    def models_var
      "@#{models_name}"
    end
  end
end

module SimpleCrud
  module ModelHelper
    def model_klass
      self.class.model_klass
    end

    # model related methods

    def model
      instance_variable_get model_var
    end

    def model_set(value)
      instance_variable_set model_var, value
    end

    def model_name
      model_klass.to_s.underscore.downcase
    end

    def model_var
      "@#{model_name}"
    end

    # models related methods

    def models
      instance_variable_get models_var
    end

    def models_set(value)
      instance_variable_set models_var, value
    end

    def models_name
      model_name.pluralize
    end

    def models_var
      "@#{models_name}"
    end

    # strong parameter methods

    def model_params
      method = permission_method
      if respond_to?(method, :include_private)
        send method
      else
        raise ArgumentError, 'Unimplemented permission method'
      end
    end

    def permission_method
      "#{model_name}_params"
    end
  end
end

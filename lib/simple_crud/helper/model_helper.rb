module SimpleCrud
  module ResourceHelper
    def resource_klass
      self.class.resource_klass
    end

    # resource related methods

    def resource_get
      instance_variable_get resource_var
    end

    def resource_set(value)
      instance_variable_set resource_var, value
    end

    def resource_name
      resource_klass.to_s.underscore.downcase
    end

    def resource_var
      "@#{resource_name}"
    end

    # resources related methods

    def resources_get
      instance_variable_get resources_var
    end

    def resources_set(value)
      instance_variable_set resources_var, value
    end

    def resources_name
      resource_name.pluralize
    end

    def resources_var
      "@#{resources_name}"
    end

    def resources_path
      send "#{resources_name}_path"
    end

    # strong parameter methods

    def resource_params
      method = permission_method
      if respond_to?(method, :include_private)
        send method
      else
        raise ArgumentError, 'Unimplemented permission method'
      end
    end

    def permission_method
      "#{resource_name}_params"
    end
  end
end

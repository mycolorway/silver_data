module InputType
  class Base
    def type; end
    def store_type; :string; end
    def options; {}; end
    def validation_options; {}; end
    def available_validations; []; end
    def template_filename; self.class.to_s.split('::').last.underscore.downcase end
    def view_path
      "#{self.class.view_root_path}#{template_filename}"
    end

    def render(_view, _form, _name, _field, _options = {})
      raise NotImplementedError
    end

    def self.view_root_path
      '_form/inputs/'
    end
  end
end

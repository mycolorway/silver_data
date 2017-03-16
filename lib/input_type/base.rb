module InputType
  class Base
    def type; end
    def options; {}; end
    def validation_options; {}; end
    def available_validations; []; end
    def view; self.class.to_s.split('::').last.downcase end

    def name; end
    def icon; end

    def self.view_root_path
      '_form/input_types/'
    end
  end
end

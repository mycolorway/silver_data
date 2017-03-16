class VirtualForm < DuckRecord::Base
  class << self
    attr_accessor :variant

    def model_name=(name)
      @_model_name = ActiveModel::Name.new(self, nil, name.classify)
    end

    def options
      @options ||= {}
    end

    def attribute_metadata
      @attribute_input_metadata ||= {}
    end

    def fields
      @fields ||= {}
    end
  end
end

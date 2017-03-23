class VirtualForm < DuckRecord::Base

  def to_h
    hash = serializable_hash
    self.class.reflections.keys.each do |k|
      records = send(k)
      sub_hash = if records.respond_to?(:to_ary)
                   records.to_ary.map { |a| a.to_h }
                 else
                   records.to_h
                 end

      if sub_hash.any?
        hash[k] = sub_hash
      end
    end

    hash
  end

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

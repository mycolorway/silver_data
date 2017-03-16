module InputType
  class TextField < Base
    def type
      :text_field
    end

    def available_validations
      [:presence, :length]
    end
  end
end

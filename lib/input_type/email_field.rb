module InputType
  class EmailField < Base
    def type
      :email_field
    end

    def validation_options
      {
        format: {with: /^[+A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i, message: 'must be a valid email'}
      }
    end

    def available_validations
      [:presence]
    end
  end
end

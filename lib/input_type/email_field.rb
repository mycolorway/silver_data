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

    def render(view, form, name, field, options = {})
      render_opt = {type: 'email'}
      view.render view_path, form: form, name: name, options: render_opt
    end
  end
end

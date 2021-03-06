module InputType
  class NumberField < Base
    def type
      :number_field
    end

    def available_validations
      [:presence, :length]
    end

    def render(view, form, name, field, options = {})
      render_opt = {}
      view.render view_path, form: form, name: name, options: render_opt
    end
  end
end

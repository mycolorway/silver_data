module InputType
  class DateField < Base
    def type
      :date_field
    end

    def store_type
      :date
    end

    def render(view, form, name, field, options = {})
      render_opt = {}
      view.render view_path, form: form, name: name, options: render_opt
    end
  end
end

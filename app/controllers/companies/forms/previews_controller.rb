class Companies::Forms::PreviewsController < Companies::Forms::ApplicationController
  before_action :build_form_model

  def show

  end

  def create

  end

  private

  def build_form_model
    @groups = []
    @form.groups.each do |g|
      model = Class.new(VirtualForm)
      model.title = g.title
      model.name = 'Group'
      model.options = {input: {}, render: {}, default: {}}

      g.fields.each do |f|
        key = f.name.to_sym
        model.options[:input][key] = {
          title: f.title,
          hint: f.hint,
          input_type: f.input_type,
          render_type: f.render_type
        }
        model.options[:default][key] = f.default_value
        model.class_eval do
          attribute key, f.data_type.to_sym
          validations = f.input_options[:validations]
          if validations.present?
            validations.each do |k, v|
              validates key, k => v
            end
          end
        end
      end
      @groups << model
    end
  end
end

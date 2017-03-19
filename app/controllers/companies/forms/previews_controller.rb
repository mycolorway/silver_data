class Companies::Forms::PreviewsController < Companies::Forms::ApplicationController
  def show
    @model = build_form_model(@form.group)
    @instance = @model.new
  end

  def create
    @model = build_form_model(@form.group)
    model_params = params.fetch(:form, {}).permit!
    @instance = @model.new model_params
    if @instance.valid?
      render :create
    else
      render :show
    end
  end

  private

  def build_form_model(group)
    model = Class.new(VirtualForm)
    model.model_name = group.name
    model.variant = group.variant

    group.fields.each do |f|
      input_type = InputType.lookup(f.input_type)
      metadata = {
        input_type: input_type,
        title: f.title,
        hint: f.hint,
        record: f
      }
      model.attribute_metadata[f.name] = metadata
      model.fields[f.name] = :field

      model.class_eval do
        attribute f.name.to_sym, input_type.store_type, default: f.input_options[:default_value]

        if f.validation_options.any?
          validates f.name.to_sym, **f.validation_options
        end
      end
    end

    model.class_eval do
      group.validation_options.each do |k, v|
        validates k, **v
      end
    end

    group.children.each do |child_group|
      child_model = build_form_model(child_group)
      child_model_name = child_group.variant == :collection ? child_group.name.pluralize : child_group.name
      model.fields[child_model_name] = :group

      model.class_eval do
        if child_model.variant == :collection
          has_many child_model_name.to_sym, anonymous_class: child_model, validate: true
          accepts_nested_attributes_for child_group.name.pluralize.to_sym, reject_if: :all_blank
        else
          has_one child_model_name.to_sym, anonymous_class: child_model, validate: true
          accepts_nested_attributes_for child_group.name.to_sym, reject_if: :all_blank
        end
      end
    end

    model
  end
end


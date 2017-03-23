class Companies::Forms::Previews::GroupsController < Companies::Forms::ApplicationController
  before_action :set_group, only: [:show]

  # GET /groups
  # GET /groups.json
  def index
    @groups = @form.group.descendants.where.not(type: Form::CollectionGroup)
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = @form.group.descendants.where.not(type: Form::CollectionGroup).find(params[:id])
    @model = build_form_model(@group)
    @instance = @model.new params.fetch(:form, {}).permit!
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = @form.group.descendants.where.not(type: Form::CollectionGroup).find(params[:id])
    @model = build_form_model(@group)
    model_params = params.fetch(:form, {}).permit!
    @instance = @model.new model_params
    if @instance.valid?
      render :create
    else
      render :show
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = @form.group.descendants.find(params[:id])
  end

  def build_form_model(group)
    model = Class.new(VirtualForm)
    model.model_name = group.name
    model.variant = group.variant

    build_fields_to_model(model, group)

    group.children.select { |g| g.class == Form::ShallowGroup }.each do |child_group|
      build_fields_to_model(model, child_group)
    end

    model
  end

  def build_fields_to_model(model, group)
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
        attribute f.name.to_sym, input_type.store_type, default: f.options[:default_value]

        if f.validations.any?
          validates f.name.to_sym, **f.validations
        end
      end
    end

    model.class_eval do
      group.validations.each do |k, v|
        validates k, **v
      end
    end

    group.children.reject { |g| g.class == Form::ShallowGroup }.each do |child_group|
      child_model = build_form_model(child_group)
      child_model_name = child_group.variant == :collection ? child_group.name.pluralize : child_group.name
      model.fields[child_model_name] = :group

      case
      when child_group.class == Form::CollectionGroup
        model.class_eval do
          has_many child_model_name.to_sym, anonymous_class: child_model, validate: true
          accepts_nested_attributes_for child_model_name.to_sym, reject_if: :all_blank
        end
      when child_group.class == Form::SimpleGroup
        model.class_eval do
          has_one child_model_name.to_sym, anonymous_class: child_model, validate: true
          accepts_nested_attributes_for child_model_name.to_sym, reject_if: :all_blank
        end
      else
        raise "unexpected #{child_group.class}"
      end
    end
  end
end

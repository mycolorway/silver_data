class FieldsController < ApplicationController
  before_action :set_field, only: [:show, :edit, :update, :destroy]

  # GET /form_fields
  # GET /form_fields.json
  def index
    @fields = @group.fields
  end

  # GET /form_fields/1
  # GET /form_fields/1.json
  def show
  end

  # GET /form_fields/new
  def new
    @field = @group.fields.build
  end

  # GET /form_fields/1/edit
  def edit
  end

  # POST /form_fields
  # POST /form_fields.json
  def create
    @field = @group.fields.build(field_params)

    respond_to do |format|
      if @field.save
        format.html { redirect_to [@company, @form, @group, @field], notice: 'Form field was successfully created.' }
        format.json { render :show, status: :created, location: [@company, @form, @group, @field] }
      else
        format.html { render :new }
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /form_fields/1
  # PATCH/PUT /form_fields/1.json
  def update
    respond_to do |format|
      if @field.update(form_field_params)
        format.html { redirect_to [@company, @form, @group, @field], notice: 'Form field was successfully updated.' }
        format.json { render :show, status: :ok, location: [@company, @form, @group, @field] }
      else
        format.html { render :edit }
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /form_fields/1
  # DELETE /form_fields/1.json
  def destroy
    @field.destroy
    respond_to do |format|
      format.html { redirect_to company_form_group_fields_url(@company, @form, @group), notice: 'Form field was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_field
      @field = @group.fields.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def field_params
      params.require(:field).permit(:name, :title, :hint, :data_type, :default_value, validation_options: [])
    end
end

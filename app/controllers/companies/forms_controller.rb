class Companies::FormsController < Companies::ApplicationController
  before_action :set_form, only: [:show, :preview, :edit, :update, :destroy]

  # GET /forms
  # GET /forms.json
  def index
    @forms = @company.forms
  end

  # GET /forms/1
  # GET /forms/1.json
  def show
    @groups = @form.groups
  end

  # GET /forms/new
  def new
    @form = @company.forms.build
  end

  # GET /forms/1/edit
  def edit
  end

  # POST /forms
  # POST /forms.json
  def create
    @form = @company.forms.build(form_params)

    respond_to do |format|
      if @form.save
        format.html { redirect_to [@company, @form], notice: 'Form was successfully created.' }
        format.json { render :show, status: :created, location: [@company, @form] }
      else
        format.html { render :new }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forms/1
  # PATCH/PUT /forms/1.json
  def update
    respond_to do |format|
      if @form.update(form_params)
        format.html { redirect_to [@company, @form], notice: 'Form was successfully updated.' }
        format.json { render :show, status: :ok, location: [@company, @form] }
      else
        format.html { render :edit }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forms/1
  # DELETE /forms/1.json
  def destroy
    @form.destroy
    respond_to do |format|
      format.html { redirect_to company_forms_url(@company), notice: 'Form was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_form
    @form = Form.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def form_params
    params.require(:form).permit(:name, :description)
  end
end

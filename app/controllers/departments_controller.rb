class DepartmentsController < ApplicationController
  before_action :set_company
  before_action :set_department, only: [:show, :edit, :update, :destroy]

  # GET /departments
  # GET /departments.json
  def index
    @departments = @company.departments
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
  end

  # GET /departments/new
  def new
    @department =  @company.departments.build
  end

  # GET /departments/1/edit
  def edit
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = @company.departments.build(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to [@company, @department], notice: 'Department was successfully created.' }
        format.json { render :show, status: :created, location: [@company, @department] }
      else
        format.html { render :new }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to [@company, @department], notice: 'Department was successfully updated.' }
        format.json { render :show, status: :ok, location: [@company, @department] }
      else
        format.html { render :edit }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to company_departments_url(@company), notice: 'Department was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_department
    @department = @company.departments.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def department_params
    params.require(:department).permit(:name)
  end
end

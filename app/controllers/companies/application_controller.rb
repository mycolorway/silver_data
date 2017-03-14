class Companies::ApplicationController < ::ApplicationController
  before_action :set_company

  private

  def set_company
    @company = Company.find(params[:company_id])
  end
end

class Companies::Forms::ApplicationController < Companies::ApplicationController
  before_action :set_form

  private

  def set_form
    @form = @company.forms.find(params[:form_id])
  end
end

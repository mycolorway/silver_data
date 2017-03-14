class Companies::Forms::Groups::ApplicationController < Companies::Forms::ApplicationController
  before_action :set_group

  private

  def set_group
    @group = @form.groups.find(params[:group_id])
  end
end

class FormField < ApplicationRecord
  belongs_to :group, class_name: 'FormGroup', foreign_key: 'form_group_id'

  serialize :input_options, Hash
  serialize :render_options, Hash

  def self.model_name
    ActiveModel::Name.new(self, nil, "Field")
  end
end

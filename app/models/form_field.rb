class FormField < ApplicationRecord
  belongs_to :group, class_name: 'FormGroup', foreign_key: 'form_group_id'

  serialize :input_options, Hash
  serialize :validation_options, Hash

  validates :name, :title, :store_type, :input_type, presence: true
  # TODO: NYI
  # validates :store_type, inclusion: { in: DuckRecord::Type.registry.registered }
  # validates :input_type, inclusion: { in: InputType.registry.registered }

  def self.model_name
    ActiveModel::Name.new(self, nil, "Field")
  end
end

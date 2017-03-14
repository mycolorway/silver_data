class FormGroup < ApplicationRecord
  has_many :fields, class_name: 'FormField'
  has_many :groups, class_name: 'FormGroup', foreign_key: 'form_group_id'

  serialize :options, Hash

  def self.model_name
    ActiveModel::Name.new(self, nil, "Group")
  end
end

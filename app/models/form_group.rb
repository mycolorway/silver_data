class FormGroup < ApplicationRecord
  belongs_to :form, inverse_of: :group

  has_ancestry

  has_many :fields, class_name: 'FormField'
  serialize :options, Hash

  def self.model_name
    ActiveModel::Name.new(self, nil, "Group")
  end
end

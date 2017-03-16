class FormGroup < ApplicationRecord
  belongs_to :form, inverse_of: :group

  has_ancestry

  has_many :fields, class_name: 'FormField'
  serialize :options, Hash
  serialize :validation_options, Hash

  validates :name, :variant, presence: true

  def variant
    super.to_sym
  end

  def options
    super || {}
  end

  def validation_options
    super || {}
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Group")
  end
end

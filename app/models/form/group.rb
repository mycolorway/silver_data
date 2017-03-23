class Form::Group < ApplicationRecord
  self.table_name = 'form_groups'

  belongs_to :form, inverse_of: :group
  has_many :fields, class_name: 'Form::Field', foreign_key: 'form_group_id'

  has_ancestry

  serialize :options, Hash
  serialize :validations, Hash

  validates :name, presence: true

  def options
    super || {}
  end

  def validations
    super || {}
  end

  def variant

  end
end

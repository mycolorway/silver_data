class Form::Field < ApplicationRecord
  self.table_name = 'form_fields'

  belongs_to :group, class_name: 'Form::Group', foreign_key: 'form_group_id'

  serialize :options, Hash
  serialize :validations, Hash

  validates :name, :title, presence: true

  def validations
    super || {}
  end

  def options
    super || {}
  end

  def input_type
  end
end

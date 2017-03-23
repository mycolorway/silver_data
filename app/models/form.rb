class Form < ApplicationRecord
  belongs_to :company

  has_one :group, class_name: 'Form::Group', dependent: :destroy
end

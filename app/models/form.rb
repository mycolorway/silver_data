class Form < ApplicationRecord
  belongs_to :company
  has_many :groups, class_name: 'FormGroup', dependent: :destroy
end

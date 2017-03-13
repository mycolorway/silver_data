class Company < ApplicationRecord
  has_many :departments, dependent: :destroy
  has_many :employees, dependent: :destroy
end

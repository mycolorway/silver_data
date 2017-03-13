class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.date :joined_at
      t.date :regularized_at
      t.references :department, foreign_key: true
      t.string :phone
      t.decimal :salary, precision: 10, scale: 2
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end

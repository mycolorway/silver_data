class CreateFormGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :form_groups do |t|
      t.string :name, null: false
      t.text :validations
      t.text :options
      t.references :form, foreign_key: true
      t.references :form_field, foreign_key: true
      t.string :ancestry
      t.index :ancestry
      t.string :type, null: false

      t.timestamps
    end
  end
end

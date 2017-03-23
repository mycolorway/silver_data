class CreateFormFields < ActiveRecord::Migration[5.0]
  def change
    create_table :form_fields do |t|
      t.string :name, null: false
      t.string :title, null: false
      t.string :hint
      t.string :type, null: false
      t.text :options
      t.text :validations
      t.references :form_group, foreign_key: true

      t.timestamps
    end
  end
end

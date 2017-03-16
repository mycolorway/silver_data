class CreateFormGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :form_groups do |t|
      t.string :name, null: false
      t.string :variant, null: false
      t.text :validation_options
      t.text :options
      t.references :form, foreign_key: true
      t.references :form_field, foreign_key: true
      t.string :ancestry
      t.index :ancestry

      t.timestamps
    end
  end
end

class CreateFormFields < ActiveRecord::Migration[5.0]
  def change
    create_table :form_fields do |t|
      t.string :name
      t.string :title
      t.string :hint
      t.string :default_value
      t.string :store_type
      t.string :input_type
      t.text :input_options
      t.text :validation_options
      t.references :form_group, foreign_key: true

      t.timestamps
    end
  end
end

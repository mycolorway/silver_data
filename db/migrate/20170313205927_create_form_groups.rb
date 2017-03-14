class CreateFormGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :form_groups do |t|
      t.string :title
      t.text :options
      t.references :form, foreign_key: true
      t.references :form_group, foreign_key: true
      t.references :form_field, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end

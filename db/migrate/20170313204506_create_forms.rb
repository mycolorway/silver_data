class CreateForms < ActiveRecord::Migration[5.0]
  def change
    create_table :forms do |t|
      t.string :title
      t.string :description
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end

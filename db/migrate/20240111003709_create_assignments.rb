class CreateAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :assignments do |t|
      t.string :name
      t.string :description
      t.integer :value
      t.string :abbreviation

      t.timestamps
    end
  end
end

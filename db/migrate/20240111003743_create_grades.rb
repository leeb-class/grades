class CreateGrades < ActiveRecord::Migration[7.1]
  def change
    create_table :grades do |t|
      t.integer :student_id
      t.integer :assignment_id
      t.decimal :value, precision: 5, scale: 2

      t.timestamps
    end
  end
end

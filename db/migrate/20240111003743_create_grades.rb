class CreateGrades < ActiveRecord::Migration[7.1]
  def change
    create_table :grades do |t|
      t.belongs_to :student
      t.belongs_to :assignment
      t.decimal :value, precision: 5, scale: 2

      t.timestamps
    end
  end
end

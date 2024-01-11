class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :email
      t.string :last_name
      t.string :athena

      t.timestamps
    end
  end
end

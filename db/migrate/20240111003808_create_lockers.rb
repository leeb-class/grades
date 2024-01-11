class CreateLockers < ActiveRecord::Migration[7.1]
  def change
    create_table :lockers do |t|
      t.string :number
      t.text :notes
      t.text :serial
      t.text :combo
      t.integer :kit

      t.timestamps
    end
  end
end

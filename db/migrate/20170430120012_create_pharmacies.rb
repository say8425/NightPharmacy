class CreatePharmacies < ActiveRecord::Migration[5.1]
  def change
    create_table :pharmacies do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :way
      t.string :monday, array: true
      t.string :tuesday, array: true
      t.string :wednesday, array: true
      t.string :thursday, array: true
      t.string :friday, array: true
      t.string :saturday, array: true
      t.string :sunday, array: true
      t.string :holiday, array: true
      t.string :hpid
      t.point :coordinates

      t.timestamps
    end
  end
end

class CreatePharmacies < ActiveRecord::Migration[5.1]
  def change
    create_table :pharmacies do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :way
      t.string :monday, array: true
      t.tstzrange :tuesday
      t.tstzrange :wednesday
      t.tstzrange :thursday
      t.tstzrange :friday
      t.tstzrange :saturday
      t.tstzrange :sunday
      t.tstzrange :holiday
      t.string :hpid
      t.point :coordinates

      t.timestamps
    end
  end
end

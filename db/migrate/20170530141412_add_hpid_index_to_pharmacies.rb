class AddHpidIndexToPharmacies < ActiveRecord::Migration[5.1]
  def change
    add_index :pharmacies, :hpid, unique: true
  end
end

class AddInfoToPharmacies < ActiveRecord::Migration[5.1]
  def change
    add_column :pharmacies, :info, :string
  end
end

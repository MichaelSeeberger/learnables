class CreateStaffProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :staff_profiles do |t|
      t.string :name

      t.timestamps
    end
  end
end

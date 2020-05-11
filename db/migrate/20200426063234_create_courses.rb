class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.references :owner, null: false, foreign_key: {to_table: :staff_profiles}

      t.timestamps
    end
  end
end

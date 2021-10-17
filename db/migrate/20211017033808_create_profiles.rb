class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :full_name
      t.string :social_name
      t.date :birth_date
      t.string :formation
      t.string :description
      t.string :photo
      t.references :occupation_area, null: false, foreign_key: true
      t.references :freelancer, null: false, foreign_key: true

      t.timestamps
    end
  end
end

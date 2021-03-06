class CreateExperiences < ActiveRecord::Migration[6.1]
  def change
    create_table :experiences do |t|
      t.string :title
      t.date :started_at
      t.date :ended_at
      t.string :description
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.string :wanted_skills
      t.decimal :max_hour_rate
      t.date :deadline
      t.boolean :available
      t.integer :status
      t.references :job_type, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

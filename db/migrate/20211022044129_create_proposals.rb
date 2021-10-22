class CreateProposals < ActiveRecord::Migration[6.1]
  def change
    create_table :proposals do |t|
      t.string :description
      t.decimal :hour_rate
      t.integer :weekly_hours
      t.integer :status
      t.references :project, null: false, foreign_key: true
      t.references :freelancer, null: false, foreign_key: true

      t.timestamps
    end
  end
end

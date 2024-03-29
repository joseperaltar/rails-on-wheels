class CreateRents < ActiveRecord::Migration[7.1]
  def change
    create_table :rents do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :status, default: 0
      t.float :price

      t.timestamps
    end
  end
end

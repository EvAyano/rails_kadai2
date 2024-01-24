class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :check_in_date
      t.date :check_out_date
      t.integer :number_of_guests
      t.decimal :total_price
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.datetime :confirmed_at

      t.timestamps
    end
  end
end

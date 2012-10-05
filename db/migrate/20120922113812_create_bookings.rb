class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :show_id
      t.string :seat_num
      t.float :sub_total

      t.timestamps
    end
  end
end

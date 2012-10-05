class CreateSeats < ActiveRecord::Migration
  def change
    create_table :seats do |t|
      t.integer :audi_id
      t.string :seat_no
      t.string :type
      t.float :price

      t.timestamps
    end
  end
end

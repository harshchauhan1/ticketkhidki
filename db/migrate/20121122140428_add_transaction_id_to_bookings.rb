class AddTransactionIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :t_id, :string
  end
end

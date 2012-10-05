class CreateAudis < ActiveRecord::Migration
  def change
    create_table :audis do |t|
      t.integer :theatre_id
      t.integer :capacity

      t.timestamps
    end
  end
end

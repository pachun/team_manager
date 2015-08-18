class CreateTeam < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :city
      t.integer :ticket_price

      t.timestamps null: false
    end
  end
end

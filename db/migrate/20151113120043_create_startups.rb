class CreateStartups < ActiveRecord::Migration
  def change
    create_table :startups do |t|
      t.string :name
      t.datetime :starting_data
      t.float :location_latitude
      t.float :location_longitude
      t.string :location_name
      t.string :category
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

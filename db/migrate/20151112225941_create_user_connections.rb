class CreateUserConnections < ActiveRecord::Migration
  def change
    create_table :user_connections do |t|
      t.integer :user_a_id
      t.integer :user_b_id
      t.integer :request_status,              null: false, default: 0

      t.timestamps null: false
    end
  end
end

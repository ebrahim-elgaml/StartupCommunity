class FixStartingDateStartup < ActiveRecord::Migration
  def change
  	rename_column :startups, :starting_data, :starting_date
  end
end

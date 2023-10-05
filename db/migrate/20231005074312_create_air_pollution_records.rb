class CreateAirPollutionRecords < ActiveRecord::Migration[5.1]
  def change
    execute "CREATE EXTENSION IF NOT EXISTS hstore"
    create_table :air_pollution_records do |t|
      t.datetime :datetime
      t.integer :aqi
      t.hstore :concentration_details
      t.integer :city_id
      t.timestamps
    end
  end
end

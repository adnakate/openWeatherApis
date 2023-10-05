class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :state
      t.string :lat
      t.string :lon
      t.timestamps
    end
  end
end

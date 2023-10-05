class AirPollutionRecord < ApplicationRecord
  belongs_to :city

  def self.average_quality_index_per_month_per_location
    self.joins(:city)
        .group('EXTRACT(MONTH FROM datetime)', 'EXTRACT(YEAR FROM datetime)', 'cities.name')
        .average(:aqi)
  end

  def self.average_quality_index_per_location
    self.joins(:city)
        .group('cities.name')
        .average(:aqi)
  end

  def self.average_quality_index_per_state
    self.joins(:city)
        .group('cities.state')
        .average(:aqi)
  end
end

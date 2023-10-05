class ImportAirPollutionDataJob < ApplicationJob
  queue_as :default

  def perform
    puts "----executing import air pollution data job-----"
    import_air_pollution_data
  end

  private

  def import_air_pollution_data
    City.all.each do |city|
      puts "-----Fetching current airpollution data for city #{city.name}------"
      url = "http://api.openweathermap.org/data/2.5/air_pollution?lat=#{city.lat.to_f}&lon=#{city.lon.to_f}&appid=#{ENV['OPEN_WEATHER_API_KEY']}"
      response = Faraday.get(url)
      air_pollution_data = eval(response.body)[:list]
      create_air_pollution_records(air_pollution_data, city)
    end
  end

  def create_air_pollution_records(air_pollution_data, city)
    air_pollution_records = []
    air_pollution_data.each do |object|
      air_pollution_record = air_pollution_record_object(object, city.id)
      air_pollution_records << air_pollution_record
    end
    AirPollutionRecord.import air_pollution_records
  end

  def air_pollution_record_object(object, city_id)
    AirPollutionRecord.new(aqi: object[:main][:aqi],
                           city_id: city_id,
                           concentration_details: object[:components],
                           datetime: Time.at(object[:dt]))
  end
end
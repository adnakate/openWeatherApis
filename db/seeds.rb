def create_cities
  puts '-----Wait we are setting cities for you-----'
  cities = ['Ahmedabad', 'Bengaluru', 'Chennai', 'Delhi', 'Hyderabad',
            'Jaipur', 'Thane', 'Kolkata', 'Pune', 'Kota',
            'Kolhapur', 'Satara', 'Sangali', 'Solapur', 'Beed',
            'Pandharpur', 'Ratnagiri', 'Indore', 'Bhopal', 'Jabalpur' ]
  cities.each do |city|
    url = "http://api.openweathermap.org/geo/1.0/direct?q=#{city}&limit=1&appid=#{ENV['OPEN_WEATHER_API_KEY']}"
    response = Faraday.get(url)
    city = eval(response.body).last
    puts city[:name]
    City.create(name: city[:name], lat: city[:lat].to_s, lon: city[:lon].to_s, state: city[:state])
  end
end

def get_historical_pollution_data
  puts '-------We are fetching historical data for cities. It may take time. Wait until it is finished-------'
  start_date = (Time.now - 1.year).utc.to_i
  end_date = (Time.now - 1.hour).utc.to_i
  City.all.each do |city|
    puts "-----Fetching historical data for city #{city.name}------"
    url = "http://api.openweathermap.org/data/2.5/air_pollution/history?lat=#{city.lat.to_f}&lon=#{city.lon.to_f}&start=#{start_date}&end=#{end_date}&appid=#{ENV['OPEN_WEATHER_API_KEY']}"
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

create_cities
get_historical_pollution_data
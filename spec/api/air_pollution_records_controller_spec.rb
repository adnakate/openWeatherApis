require 'rails_helper'

RSpec.describe "Api::AirPollutionRecordsController", type: :request do

  before (:each) do
    @city_1 = City.create(name: 'Mumbai', lat: "10", lon: "10", state: "Maharashtra")
    @city_2 = City.create(name: 'Pune', lat: "10", lon: "10", state: "Maharashtra")
    @city_3 = City.create(name: 'Indore', lat: "10", lon: "10", state: "Madhya Pradesh")
    @city_4 = City.create(name: 'Bhopal', lat: "10", lon: "10", state: "Madhya Pradesh")
    @city_5 = City.create(name: 'Jabalpur', lat: "10", lon: "10", state: "Madhya Pradesh")
    concentration_details = {"co"=>"10", "no"=>"10", "o3"=>"10", "nh3"=>"10", "no2"=>"10", "so2"=>"10", "pm10"=>"10", "pm2_5"=>"10"}
    AirPollutionRecord.create(city_id: @city_1.id,  aqi: 4, concentration_details: concentration_details, datetime: Time.now)
    AirPollutionRecord.create(city_id: @city_2.id,  aqi: 4, concentration_details: concentration_details, datetime: Time.now)
    AirPollutionRecord.create(city_id: @city_3.id,  aqi: 4, concentration_details: concentration_details, datetime: Time.now)
    AirPollutionRecord.create(city_id: @city_4.id,  aqi: 4, concentration_details: concentration_details, datetime: Time.now)
    AirPollutionRecord.create(city_id: @city_5.id,  aqi: 4, concentration_details: concentration_details, datetime: Time.now)
    AirPollutionRecord.create(city_id: @city_1.id,  aqi: 4, concentration_details: concentration_details, datetime: Time.now)
    AirPollutionRecord.create(city_id: @city_2.id,  aqi: 4, concentration_details: concentration_details, datetime: Time.now)
    AirPollutionRecord.create(city_id: @city_3.id,  aqi: 4, concentration_details: concentration_details, datetime: Time.now)
    AirPollutionRecord.create(city_id: @city_4.id,  aqi: 4, concentration_details: concentration_details, datetime: Time.now)
    AirPollutionRecord.create(city_id: @city_5.id,  aqi: 4, concentration_details: concentration_details, datetime: Time.now)
    AirPollutionRecord.create(city_id: @city_1.id,  aqi: 4, concentration_details: concentration_details, datetime: Time.now)
    AirPollutionRecord.create(city_id: @city_2.id,  aqi: 4, concentration_details: concentration_details, datetime: Time.now)
    AirPollutionRecord.create(city_id: @city_3.id,  aqi: 4, concentration_details: concentration_details, datetime: Time.now)
    AirPollutionRecord.create(city_id: @city_4.id,  aqi: 4, concentration_details: concentration_details, datetime: Time.now)
    AirPollutionRecord.create(city_id: @city_5.id,  aqi: 4, concentration_details: concentration_details, datetime: Time.now)
  end

  describe "get average_quality_index_per_month_per_location" do
    it "should give number 5 number of records" do
      get "/api/air_pollution_records/average_quality_index_per_month_per_location"
      expect(response).to have_http_status :ok
      response_body = JSON.parse(response.body)
      expect(response_body["records"].count).to eq(5)
    end

    it "the average aqi per month per city should be 4" do
      get "/api/air_pollution_records/average_quality_index_per_month_per_location"
      expect(response).to have_http_status :ok
      response_body = JSON.parse(response.body)
      expect(response_body["records"][0]["aqi"]).to eq(4)
      expect(response_body["records"][1]["aqi"]).to eq(4)
      expect(response_body["records"][2]["aqi"]).to eq(4)
      expect(response_body["records"][3]["aqi"]).to eq(4)
      expect(response_body["records"][4]["aqi"]).to eq(4)
    end
  end

  describe "get average_quality_index_per_location" do
    it "should give number 5 number of records" do
      get "/api/air_pollution_records/average_quality_index_per_location"
      expect(response).to have_http_status :ok
      response_body = JSON.parse(response.body)
      expect(response_body["records"].count).to eq(5)
    end

    it "the average aqi per city should be 4" do
      get "/api/air_pollution_records/average_quality_index_per_location"
      expect(response).to have_http_status :ok
      response_body = JSON.parse(response.body)
      expect(response_body["records"][0]["aqi"]).to eq(4)
      expect(response_body["records"][1]["aqi"]).to eq(4)
      expect(response_body["records"][2]["aqi"]).to eq(4)
      expect(response_body["records"][3]["aqi"]).to eq(4)
      expect(response_body["records"][4]["aqi"]).to eq(4)
    end
  end

  describe "get average_quality_index_per_state" do
    it "should give number 2 number of records" do
      get "/api/air_pollution_records/average_quality_index_per_state"
      expect(response).to have_http_status :ok
      response_body = JSON.parse(response.body)
      expect(response_body["records"].count).to eq(2)
    end

    it "the average aqi per state should be 4" do
      get "/api/air_pollution_records/average_quality_index_per_state"
      expect(response).to have_http_status :ok
      response_body = JSON.parse(response.body)
      expect(response_body["records"][0]["aqi"]).to eq(4)
      expect(response_body["records"][1]["aqi"]).to eq(4)
    end
  end
end
class Api::AirPollutionRecordsController < ApplicationController

  def average_quality_index_per_month_per_location
    records = AirPollutionRecord.average_quality_index_per_month_per_location
    formatted_records = []
    records.each do |record|
      formatted_records << average_aqi_per_month_per_location_record(record)
    end
    render json: { records: formatted_records }, status: 200
  end

  def average_quality_index_per_location
    records = AirPollutionRecord.average_quality_index_per_location
    formatted_records = []
    records.each do |record|
      formatted_records << average_aqi_per_location_record(record)
    end
    render json: { records: formatted_records }, status: 200
  end

  def average_quality_index_per_state
    records = AirPollutionRecord.average_quality_index_per_state
    formatted_records = []
    records.each do |record|
      formatted_records << average_aqi_per_state_record(record)
    end
    render json: { records: formatted_records }, status: 200
  end

  private

  def average_aqi_per_month_per_location_record(record)
    grouped_by, aqi = record.first, record.last.to_f.round(2)
    { city: grouped_by[2], month_year: "#{grouped_by[0].to_i}-#{grouped_by[1].to_i}", aqi: aqi }
  end

  def average_aqi_per_location_record(record)
    { city: record.first, aqi: record.last.to_f.round(2) }
  end

  def average_aqi_per_state_record(record)
    { city: record.first, aqi: record.last.to_f.round(2) }
  end
end
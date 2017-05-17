require 'HTTParty'
require 'pry'
class Distance
  KEY = 'AIzaSyBiZIyGFMSgVAu39pd4p45XaTzOpNUl734'.freeze

  def initialize(city_a, city_b)
    @city_a = city_a
    @city_b = city_b
  end

  def calculate_distance
    url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{@city_a}&destinations=#{@city_b}&key=#{KEY}"
    response = HTTParty.get(url)
    miles = response.to_h.dig('rows').first.dig('elements').first.dig('distance', 'text') #.gsub!(/\d/).first
    miles
  end

  def calculate_duration
    url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{@city_a}&destinations=#{@city_b}&key=#{KEY}"
    response = HTTParty.get(url)
    response.to_h.dig('rows').first.dig('elements').first.dig('duration', 'text')
  end

  private

  def miles_to_km(miles)
    (miles.to_i * 1.609344 * 100).to_s + ' kms'
  end
end

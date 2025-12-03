require 'net/http'
require 'dotenv/load'

module Aoc
  Dotenv.load('.env')
  def self.get_input_for_day(day)
    uri = URI("https://adventofcode.com/2025/day/#{day}/input")
    headers = { 'Cookie' => ENV['SESSION'] }
    Net::HTTP.get(uri, headers)
  end
end


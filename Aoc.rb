require 'net/http'

module Aoc

  SESSION = 'YOUR_SESSION_HERE'

  def self.get_input_for_day(day)
    uri = URI("https://adventofcode.com/2025/day/#{day}/input")
    headers = { 'Cookie' => "session=#{SESSION}" }
    Net::HTTP.get(uri, headers)
  end
end

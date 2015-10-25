#!/usr/bin/env ruby
# Clinton Cario -- BERC Hackathon 10/24/15
## This script will lookup the US census FIPS ID for given lat/lon valus using the fcc.gov api
## Inputs:
##   input file: A CSV file with the first 3 columns as: lat, lon, and apn
##   output file name: The name of the file to write to
## Outputs:
##   a file with three columns: lat, lon, apn, and the censusID
​
require 'nokogiri'
require 'open-uri'
require 'json'
require 'csv'
​
​
CSV.open(ARGV[1], 'wb') do |outfile|
  infile = CSV.parse(File.read(ARGV[0]), :headers => true)
  infile.each do |row|
    lat,lon, apn  = row[0], row[1], row[2]
    api_url       = "http://data.fcc.gov/api/block/find?format=json&latitude=#{lat}&longitude=#{lon}&showall=false"
    doc           = JSON.parse(Nokogiri::HTML(open(api_url)))
    censusID      = doc["Block"]["FIPS"]
    outfile << [lat, lon, apn, censusID]
    puts "Querying... [#{lat},#{lon}] ==> #{censusID}"
  end
end

require 'nokogiri'
require 'date'

ENTRIES_PATH = "../../../Dropbox/Apps/Day\ One/Journal.dayone/entries/"

map = {}

Dir.glob(ENTRIES_PATH + "*.doentry") do |filename|
    file = File.read(filename)
    xml = Nokogiri::XML(file)

    node = xml.xpath("//dict[1]").first

    date = node.xpath(".//date").first.content
    timestamp = Date.parse(date).to_time.to_i

    entry = node.xpath(".//string").first.content

    #TODO: nlp through entry to get keywords
    keywords = entry

    map[timestamp] = keywords
end

puts map

#TODO: create new map that maps bucket timestamps => { keyword => count }

#TODO: create json file to visualize

require "json"
require "vessel"

class Makroscope < Vessel::Cargo
  domain "makroscope.eu"
  start_urls "https://makroscope.eu/termine/"

  def parse
    css(".wcs-timetable__list li").each do |item|
      yield({
        title: item.at_css(".wcs-class__title").text,
        description: item.at_css(".wcs-class__excerpt p").text,
        date: item.at_css(".wcs-class__time").attribute(:datetime)
      })
    end
  end
end

items = []
Makroscope.run { |i| items << i }
File.open("makroscope.json", 'w') do |file|
  file.write(items.to_json)
end

require 'open-uri'

desc "Scrapes Faculty Page for a List of Instructors"
namespace :scrape do
  task :faculty => :environment do
    instructors = []
    (1..1).each do |t|
      body = Nokogiri::HTML(open("https://sutd.edu.sg/About-Us/People/Faculty?jobtype=1&page=#{t}", "Accept-Encoding" => "plain"))
      body.css("ul.faculty-listing li .snippet").each do |item|
        instructor_name = item.at_css("a").xpath('text()').text
        designation = item.at_css(".designment").xpath('text()').text
        faculty = item.at_css(".faculty").xpath('text()').text
        research_area = item.at_css(".research-area").xpath('text()').text
        # instructors << Instructor.new(name: )
      end
    end
  end
end
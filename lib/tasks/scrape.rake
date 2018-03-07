require 'open-uri'

desc "Scrapes Faculty Page for a List of Instructors"
namespace :scrape do
  task :faculty => :environment do
    p "Scraping.."
    instructors = []
    (1..14).each do |t|
      p "Page #{t}.."
      body = Nokogiri::HTML(open("https://sutd.edu.sg/About-Us/People/Faculty?jobtype=1&page=#{t}", "Accept-Encoding" => "plain"))
      body.css("ul.faculty-listing li").each do |item|
        instructor_name = item.at_css(".snippet a").xpath('text()').text
        designation = item.at_css(".snippet .designation").xpath('text()').text
        faculty = item.at_css(".snippet .faculty").xpath('text()').text
        research_area = item.at_css(".snippet .research-area").xpath('text()').text
        avatar = item.at_css(".img-holder img")["src"]

        p "Adding #{instructor_name.squish}"
        instructors << {
          name: instructor_name.squish,
          designation: designation.strip, 
          faculty: faculty.strip, 
          research_area: research_area.strip,
          password: 'password',
          password_confirmation: 'password',
          avatar: avatar,
          email: instructor_name.parameterize.underscore + "@sutd.edu.sg"
        }
      end
    end
    p "Adding instructors to database.."
    Instructor.create!(instructors)
    p "Created."
  end
end
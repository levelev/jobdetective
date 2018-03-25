require 'csv'
require 'faker'
require 'open-uri'
require 'nokogiri'
require 'json'



# Seed Company Employees from json

# # Babbel
# filepath = Rails.root.join('lib', 'seeds','babbel2.json')
# serialized_users = File.read(filepath)
# users = JSON.parse(serialized_users)
# c = Company.find_by_name("Babbel"),
# employees = c.users

# employees.each do |user|
#   user.destroy
# end

# users.each do |user|
#   u = User.new(
#     company: c,
#     email: user["email"],
#     password: Faker::Crypto.md5,
#     linkedin_pic_url: "http://res.cloudinary.com/dbp2j1emu/image/upload/q_auto:eco/v1512407043/default_user_dizcx8.jpg",
#     first_name: user["name"]["givenName"],
#     last_name: user["name"]["familyName"],
#     employment_role: user["title"]
#     )
# end



# Volders
filepath = Rails.root.join('lib', 'seeds','volders.json')
serialized_users = File.read(filepath)
users = JSON.parse(serialized_users)


# c = Company.find_by_name("Volders"),
# employees = c.users

# employees.each do |user|
#   user.destroy
# end

users.each do |user|
  u = User.new(
    company: Company.find_by_name("Volders")
    email: user["email"],
    password: Faker::Crypto.md5,
    linkedin_pic_url: "http://res.cloudinary.com/dbp2j1emu/image/upload/q_auto:eco/v1512407043/default_user_dizcx8.jpg",
    first_name: user["name"]["givenName"],
    last_name: user["name"]["familyName"],
    employment_role: user["title"]
    )
end

# Movinga
filepath = Rails.root.join('lib', 'seeds','movinga.json')
serialized_users = File.read(filepath)
users = JSON.parse(serialized_users)


c = Company.find_by_name("Movinga")
# employees = c.users

# employees.each do |user|
#   user.destroy
# end

users.each do |user|
  u = User.new(
    company: c,
    email: user["email"],
    password: Faker::Crypto.md5,
    linkedin_pic_url: "http://res.cloudinary.com/dbp2j1emu/image/upload/q_auto:eco/v1512407043/default_user_dizcx8.jpg",
    first_name: user["name"]["givenName"],
    last_name: user["name"]["familyName"],
    employment_role: user["title"]
    )
end


# lookup["person"]["avatar"]







# # Create Companies from Crunchbase CSV
# csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
# csv_text = File.read(Rails.root.join('lib', 'seeds', 'crunch.csv'))

# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
#   #Create Company
#   c = Company.new
#   c.name = row['name']
#   c.city = row['location_city']
#   c.country = row['location_country_code']
#   c.short_description = row['short_description']
#   c.logo_url = row['profile_image_url']
#   c.homepage_url = row['homepage_url']
#   c.homepage_domain = row['homepage_domain']
#   c.crunchbase_url = row['crunchbase_url'].gsub(/\?\S*/, "")
#   c.save
#   p "Created Company #{c.name}"


#   # Create Employees - Faker
#   role = %w(management engineering sales product operations HR)

#   rand(4..8).times do
#     u = User.create!(
#       company: c,
#       email: Faker::Internet.email,
#       password: Faker::Crypto.md5,
#       linkedin_pic_url: "http://res.cloudinary.com/dbp2j1emu/image/upload/q_auto:eco/v1512407043/default_user_dizcx8.jpg",
#       first_name: Faker::Name.first_name,
#       last_name: Faker::Name.last_name,
#       employment_role: role.sample
#       )
#   end

  # # Scraping Employees from Angellist Ads
  # angel = "https://angel.co/"
  # company_name = c.name.downcase.gsub(" se", "").gsub(" gmbh", "").gsub(" ag", "").gsub(" ug", "").gsub(" ","-")
  # angel_url = "#{angel}#{company_name}/jobs"

  # team_array = []
  # p "Fetching #{angel_url}"
  # begin
  #   doc = Nokogiri::HTML(open(angel_url), nil, 'utf-8')
  # rescue
  #   puts "404 rescued"
  #   # c.destroy!
  #   # puts "#{c.name} deleted"
  # end
  # unless doc == nil
  #   doc.search('.team-members > div > div').each do |section|
  #     section.css('.card').each do |profile|
  #       img = profile.css('img').first.attributes["src"].value
  #       p img
  #       name = profile.css('img').first.attributes["alt"].value
  #       p name
  #       subtitle = profile.css('.object-list-subtitle').text.strip
  #       p subtitle

  #       User.create!(
  #         company: c,
  #         email: Faker::Internet.email,
  #         password: Faker::Crypto.md5,
  #         linkedin_pic_url: img,
  #         first_name: name,
  #       # last_name: Faker::Name.last_name,
  #       employment_role: subtitle
  #       )
  #     end
  #   end
  # end

#   # Scraping Techs for Company - STACKSHARE
#   stackshare = "https://stackshare.io/"
#   company_name = c.name.downcase.gsub(" se", "").gsub(" gmbh", "").gsub(" ag", "").gsub(" ug", "").gsub(" ","-")
#   stack_url = "#{stackshare}#{company_name}/#{company_name}"

#   p "Fetching #{stack_url}"
#   stack_tools = []
#   stack_tools_hash = {}
#   begin
#     doc = Nokogiri::HTML(open(stack_url), nil, 'utf-8')
#   rescue
#     puts "404 rescued"
#     c.destroy!
#     puts "#{c.name} deleted"
#   end
#   unless doc == nil
#     array_of_tools = []
#     doc.search('#stack-item-services-tile').each do |section|
#       section.css('#stp-services').each do |element|
#         img = element.css('img').first.attributes["src"].value
#         p img
#         title = element.css('a.stack-service-name-under').first.text
#         p title
#         tool = {
#           name: title,
#           picture: img
#         }
#         array_of_tools << tool
#       end

#       array_of_tools.uniq.each do |tool|
#         current_tool = Tool.find_by_name(tool[:name])
#         if current_tool
#           ct = CompanyTool.create!(
#             company: c,
#             tool: current_tool,
#             )
#         else
#           new_tool = Tool.new(
#             name: tool[:name],
#             image_url: tool[:picture]
#             )
#           new_tool.save
#           ct = CompanyTool.create!(
#             company: c,
#             tool: new_tool,
#             )
#         end
#       end
#     end
#   end
# end


# How to use Curl
# curl --silent 'https://angel.co/uber/jobs' > uber.html


  # c = Company.new
  # c.name = "Uber"
  # # c.city = row['location_city']
  # # c.country = row['location_country_code']
  # # c.short_description = row['short_description']
  # c.logo_url = "https://www.carthage.edu/live/image/gid/40/width/250/18567_uber-logo-2bb8ec4342-seeklogo.com.rev.1505839766.png"
  # # c.homepage_url = row['homepage_url']
  # # c.homepage_domain = row['homepage_domain']
  # # c.crunchbase_url = row['crunchbase_url'].gsub(/\?\S*/, "")
  # c.save
  # p "Created Company #{c.name}"



  # file = "/Users/daniel/Downloads/uber.html"
  # doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')
  # team_array = []

  # doc.search('.team-members > div > div').each do |section|
  #   section.css('.card').each do |profile|
  #     img = profile.css('img').first.attributes["src"].value
  #     p img
  #     name = profile.css('img').first.attributes["alt"].value
  #     p name
  #     subtitle = profile.css('.object-list-subtitle').text.strip
  #     p subtitle

  #     User.create!(
  #       company: c,
  #       email: Faker::Internet.email,
  #       password: Faker::Crypto.md5,
  #       linkedin_pic_url: img,
  #       first_name: name,
  #       # last_name: Faker::Name.last_name,
  #       employment_role: subtitle
  #     )
  #   end
  # end










      # person = {
      #   name: name,
      #   picture: img,
      #   subtitle: subtitle
      # }

      # team_array << person

      # team_array.uniq.each do |person|
      #   u = User.create!(
      #     company: c,
      #     email: Faker::Internet.email,
      #     password: Faker::Crypto.md5,
      #     linkedin_pic_url: person[:picture],
      #     first_name: person[:name],
      #     # last_name: Faker::Name.last_name,
      #     employment_role: person[:subtitle]
      #   )






require 'csv'
require 'faker'
require 'open-uri'
require 'nokogiri'


# Create Companies from Crunchbase CSV
csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
csv_text = File.read(Rails.root.join('lib', 'seeds', 'crunch.csv'))

csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  #Create Company
  c = Company.new
  c.name = row['name']
  c.city = row['location_city']
  c.country = row['location_country_code']
  c.short_description = row['short_description']
  c.logo_url = row['profile_image_url']
  c.homepage_url = row['homepage_url']
  c.homepage_domain = row['homepage_domain']
  c.crunchbase_url = row['crunchbase_url'].gsub(/\?\S*/, "")
  c.save
  p "Created Company #{c.name}"

  # Scraping Techs for Company - STACKSHARE
  stackshare = "https://stackshare.io/"
  company_name = c.name.downcase.gsub(" se", "").gsub(" gmbh", "").gsub(" ag", "").gsub(" ug", "").gsub(" ","-")
  stack_url = "#{stackshare}#{company_name}/#{company_name}"

  p "Fetching #{stack_url}"
  stack_tools = []
  stack_tools_hash = {}
  begin
    doc = Nokogiri::HTML(open(stack_url), nil, 'utf-8')
  rescue
    puts "404 rescued"
    c.destroy!
    puts "#{c.name} deleted"
  end
  unless doc == nil
    # doc.search('#stp-services > .stack-service-name-under').each do |element|
    # doc.search('#stp-services').each do |element|
    #   tool_name = element.search('.stack-service-name-under').text.strip.gsub(/\n.*/,"")
    #   tool_picture = element.search('img')
    array_of_tools = []
    doc.search('#stack-item-services-tile').each do |section|
      # tool_name = element.search('.stack-service-name-under').text.strip.gsub(/\n.*/,"")
      # tool_picture = element.search('img'


      section.css('#stp-services').each do |element|
        img = element.css('img').first.attributes["src"].value
        p img
        title = element.css('a.stack-service-name-under').first.text
        p title
        tool = {
          name: title,
          picture: img
        }
        array_of_tools << tool
      end
      # tool = {
      #   name: element.attributes["alt"].value,
      #   picture: element.attributes["src"].value
      # }

      # # stack_tools_hash[:name] = element.attributes["alt"].value # element['alt']# tool_name
      # # p element.alt
      # # stack_tools_hash[:picture] = element.attributes["src"].value  #element['currentSrc'] # tool_picture.first.attributes["src"].try(:value)
      # # p element.currentSrc
      # # stack_tools << stack_tools_hash
      # # p stack_tools_hash
      # # # p "printing stack tools"
      # array_of_tools << tool
    end

    # p "============================================"
    # p "Tools for #{c.name} #{stack_tools}"
    # p "============================================"



    # example_for_tool = {:name=>"Salesforce Sales Cloud", :picture=>"https://img.stackshare.io/service/35/lGZFUPOW.png"}


    # array_of_tools.uniq


    array_of_tools.uniq.each do |tool|
      current_tool = Tool.find_by_name(tool[:name])
      if current_tool
      # p "current_tool #{current_tool.name}"
         ct = CompanyTool.create!(
        company: c,
        tool: current_tool,
        )
      else
        new_tool = Tool.new(
          name: tool[:name],
          image_url: tool[:picture]

          )
        new_tool.save
        ct = CompanyTool.create!(
        company: c,
        tool: new_tool,
        )
      end
    end
  end
end




    # stack_tools.each do |tool|
    #   current_tool = Tool.find_by_name("tool")
    #   if current_tool
    #      ct = CompanyTool.create!(
    #     company: c,
    #     tool: current_tool,
    #     # image_url:
    #     )
    #   else
    #     new_tool = Tool.create!(
    #       name: tool.gsub(/\[\d*\]/, "")
    #       )
    #     ct = CompanyTool.create!(
    #     company: c,
    #     tool: new_tool,
    #     # image_url:
    #     )
    #   end
    # end



# Create Employees - Faker
role = %w(management engineering sales)

50.times do
  pic_uid = rand(1..10)
  u = User.create!(
    # name: Faker::Name.name,
    company: Company.order("RANDOM()").first,
    email: Faker::Internet.email,
    password: Faker::Crypto.md5,
    linkedin_pic_url: "http://lorempixel.com/100/100/people/#{pic_uid}",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    employment_role: role.sample
    )
end

# #   # Scraping people from Angellist

# #   # angel_url = "https://angel.co/"
# #   company = c.name.gsub(" ", "-").gsub(".", "-")
#   people = []
# #   nokogiri_hash = {}
#   user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"

# #   p "Scraping People from AngelList forh ttps://angel.co/#{company}"


# puts "-------------------------------------- "
# puts "Testing lewagon"



#   begin
#     # doc = Nokogiri::HTML(open("https://angel.co/#{company}", 'User-Agent' => user_agent,), nil, 'utf-8')
#     doc = Nokogiri::HTML(open("https://angel.co/le-wagon", 'User-Agent' => user_agent,), nil, 'utf-8')

#     puts doc

#   rescue
#     puts "404 rescued"
#     # c.destroy!
#     puts "#{c.name} deleted"
#   end
#   unless doc == nil
#     doc.search('.profile-link').each do |element|
#       people << element.text
#     end

# p people
# p "Numbers of employees"
# p people.count


     # .name > .profile-link # Name & Link
     #  .role_title #Role
     #  .bio # Beschreibung
     #  .angel_image #bild


  #   u = User.create!(
  #   first_name: person,
  #   company: c,
  #   email: Faker::Internet.email,
  #   password: Faker::Crypto.md5,
  #   # linkedin_pic_url: "http://lorempixel.com/100/100/people/#{pic_uid}",
  #   # first_name: Faker::Name.first_name,
  #   # last_name: Faker::Name.last_name,
  #   # employment_role: role.sample
  #   )
  # end
# end

























# # require 'clearbit'
# # Clearbit.key = ENV['CLEARBIT']


# # # Load Companies from CSV & Add Users from Clearbit

# # csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
# # csv_text = File.read(Rails.root.join('lib', 'seeds', 'crunch.csv'))

# # csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# # csv.each do |row|
# #   #Create Company
# #   c = Company.new
# #   c.name = row['name']
# #   c.city = row['location_city']
# #   c.country = row['location_country_code']
# #   c.short_description = row['short_description']
# #   c.logo_url = row['profile_image_url']
# #   c.homepage_url = row['homepage_url']
# #   c.homepage_domain = row['homepage_domain']
# #   c.save
# #   p "Created Company #{c.name}"

# #   # Fetch clearbit data
# #   p "Fetching clearbit employees for #{c.homepage_domain}"
# #   people = Clearbit::Prospector.search(domain: c.homepage_domain)

# #   people.each do |user|
# #     # Create Users from Clearbit data
# #     u = User.create!(
# #      company: c,
# #      email: user["email"],
# #      password: Faker::Crypto.md5,
# #      linkedin_pic_url: "https://dizivizi.com/mbb/imgs/site/default_user.png",
# #      first_name: user["name"]["givenName"],
# #      last_name: user["name"]["familyName"],
# #      employment_role: user["role"],
# #      title: user["title"],
# #      seniority: user["seniority"]
# #      )
# #     p "Created User #{u.first_name} #{u.last_name}"
# #   end
# # end







# # # Clearbit example
# # # company = Clearbit::Enrichment::Company.find(domain: 'babbel.com') #returns company

# # # people = Clearbit::Prospector.search(domain: 'babbel.com')

# # # people.each do |person|
# # #   puts [person.name.full_name, person.title].join(' - ')
# # # end

# # # Clearbit People Search results => Array
# # # [
# # # {"id"=>"e_c8ada464-06e5-4f61-9697-a33a42e8b029", "name"=>{"fullName"=>"Boris Diebold", "givenName"=>"Boris", "familyName"=>"Diebold"}, "title"=>"CTO", "role"=>"engineering", "seniority"=>"executive", "email"=>"bdiebold@babbel.com", "verified"=>true}
# # # {"id"=>"e_53880e74-0029-4567-9c85-46453dc63378", "name"=>{"fullName"=>"Markus Witte", "givenName"=>"Markus", "familyName"=>"Witte"}, "title"=>"CEO", "role"=>"ceo", "seniority"=>"executive", "email"=>"mwitte@babbel.com", "verified"=>true}
# # # {"id"=>"e_173074bf-fb92-457f-a100-562f46559a4d", "name"=>{"fullName"=>"Deepa Miglani", "givenName"=>"Deepa", "familyName"=>"Miglani"}, "title"=>"SVP, Marketing", "role"=>"marketing", "seniority"=>"executive", "email"=>"dmiglani@babbel.com", "verified"=>true}
# # # {"id"=>"e_82caeebe-b8eb-43eb-8ed4-21fbc75faf86", "name"=>{"fullName"=>"Scott Weiss", "givenName"=>"Scott", "familyName"=>"Weiss"}, "title"=>"VP Product Design", "role"=>"product", "seniority"=>"executive", "email"=>"sweiss@babbel.com", "verified"=>true}
# # # {"id"=>"e_7910a985-570c-4d73-bea8-5bfb3db0c07a", "name"=>{"fullName"=>"Julie Hansen", "givenName"=>"Julie", "familyName"=>"Hansen"}, "title"=>"CEO, US", "role"=>"ceo", "seniority"=>"executive", "email"=>"jhansen@babbel.com", "verified"=>true}
# # # ]

# # # User from Clearbit
# # # company = "Babbel"
# # # user = {"id"=>"e_c8ada464-06e5-4f61-9697-a33a42e8b029", "name"=>{"fullName"=>"Boris Diebold", "givenName"=>"Boris", "familyName"=>"Diebold"}, "title"=>"CTO", "role"=>"engineering", "seniority"=>"executive", "email"=>"bdiebold@babbel.com", "verified"=>true}

# # # u = User.create!(
# # #     company: Company.find_by_name(company),
# # #     email: user["email"],
# # #     password: Faker::Crypto.md5,
# # #     linkedin_pic_url: "https://dizivizi.com/mbb/imgs/site/default_user.png",
# # #     first_name: user["name"]["givenName"],
# # #     last_name: user["name"]["familyName"],
# # #     employment_role: user["role"],
# # #     title: user["title"],
# # #     seniority: user["seniority"]
# # #     )
# # # u.each do |e|
# # #   puts e
# # # end




# # # # file = "/Users/daniel/Downloads/built.html"
# # # # doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')

# # # # doc.search('.techItem > h3').each_with_index do |element, index|
# # # #   puts "#{index + 1}. #{element.text.strip}"
# # # # end


#   # stack_query_url = "https://stackshare.io/search/q=zalando"
#   # doc = Nokogiri::HTML(open(stack_query_url), nil, 'utf-8')
#   # stack_company = doc.search("").text
#   # p stack_company
#   # stack_url = "https://stackshare.io#{stack_company}




#   # # stack_url = "https://stackshare.io/zalando/zalando"
#   # stack_tools = []
#   # p "Fetching #{stack_url}"
#   #   doc = Nokogiri::HTML(open(stack_url), nil, 'utf-8')
#   #   doc.search('.stack-service-name-under').each do |element|
#   #   stack_tools << element.text.strip
#   #   p "#{stack_tools}"
#   # end

# #   # Scraping Techs for Company - BUILTWITH
# #   builtwith = "https://builtwith.com/"
# #   bw_url = "#{builtwith}#{c.homepage_domain}"
# #   bw_tools = []
# #   p "Start scraping #{bw_url}"
# #   doc = Nokogiri::HTML(open(bw_url), nil, 'utf-8')
# #   doc.search('.techItem > h3').each do |element|
# #     bw_tools << element.text.strip
# #   p "bw_tools #{bw_tools}"
# #   end
# #   # p "Scraping complete"

# #   # for each tool check if exits
# #   bw_tools.each do |tool|
# #     exist = Tool.find_by_name(tool)
# #     if exist
# #       p "#{tool} found in DB."
# #       ct = CompanyTool.create!(
# #         company: c,
# #         tool: exist
# #         )
# #       ct.save
# #       p "CompanyTool created"
# #     else
# #       p "#{tool} NOT found. Creating.."
# #       new_tool = Tool.new
# #       new_tool.name = tool
# #       new_tool.save
# #       ct = CompanyTool.create!(
# #         company: c,
# #         tool: new_tool
# #         )
# #       ct.save
# #       p "CompanyTool created"
# #     end
# #   end
# # end



# tools = %w(rails php asp python facebook adwords git css html javascript)

# tools.each do |technology|
#   t = Tool.create!(
#     name: technology
#     )
# end


# 50.times do
#   ct = CompanyTool.create!(
#     company_id: rand(1..10),
#     tool_id: rand(1..10)
#     )
# end


# # # 10.times do
# # #   ct = UserTool.create!(
# # #     user_id: rand(1..10),
# # #     tool_id: rand(1..10)
# # #     )
# # # end



# Create Employees from Crunchbase

# crunchbase = "https://www.crunchbase.com"
# url = "https://angel.co/zalando-se-1" # replace by: c.
# # cb_person_regex = /<a class="cb-link" href="\/person\/\S*>/
# team_urls = []

# user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"

# # file = "/Users/daniel/Downloads/wagon.html"
# # doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')

# doc = Nokogiri::HTML(open(url, 'User-Agent' => user_agent,), nil, 'utf-8')
# doc.search('.profile-link').each do |e|
#   puts e
# end

# # p doc

# # How to use Curl
# curl --silent 'https://www.crunchbase.com/organization/le-wagon' > wagon.html

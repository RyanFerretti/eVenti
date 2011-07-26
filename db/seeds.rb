locations = [["Camden","NJ",true],["Scranton","PA",true],["Boston","MA",true],["Washington","DC",true],["Virginia Beach","VA",true],
  ["Tampa","FL",true],["Biloxi","MS",true],["Houston","TX",true],["Detroit","MI",true],["Buffalo","NY",true],["Hartford","CT",true],
  ["Montreal","QC",false],["Toronto","ON",true],["Pittsburgh","PA",true],["Indianapolis","IN",true],["Chicago","IL",true],
  ["Milwaukee","WI",false],["Cleveland","OH",true],["Omaha","NE",true],["Kansas City","MO",true],["St Louis","MO",true],["Calgary","AB",true],
  ["Edmonton","AB",true],["Auburn","WA",true],["Spokane","WA",false],["West Valley City","UT",false],["Denver","CO",true],["Albuquerque","NM",true],
  ["Phoenix","AZ",true],["San Diego","CA",true],["Sacramento","CA",true],["San Francisco","CA",true]
]

locations.each do |loc|
  Location.create! :city => loc[0], :state => loc[1], :active => loc[2]
end

Admin.create! :email => "admin@gmail.com", :password => "admin123", :password_confirmation => "admin123"
c = Client.create!:email => "client@gmail.com", :password => "client123", :password_confirmation => "client123", :confirmation_sent_at => "2011-01-01 11:00:00"
c.confirmed_at = DateTime.now
c.save!


def add_pictures(member,dir)
  1.upto 3 do |j|
    p = member.pictures[j-1]
    p.image = File.open(File.join("#{Rails.root}","test","pictures","#{dir}","#{j}.jpg"))
    p.save!
  end
end

1.upto 18 do |i|
  m = Member.create!:email => "member#{i}@gmail.com", :first_name => "member#{i}", :profile_name => "member#{i}", :password => "member123", :password_confirmation => "member123", :confirmation_sent_at => "2011-01-01 11:00:00"
  m.confirmed_at = DateTime.now
  m.member_summary.location = Location.find((i%3)+1)
  m.member_summary.city = "Chicago"
  m.member_summary.state = "il"
  m.ratings.create(:value => (i%10)+1)
  m.ratings.create(:value => (i+1%10)+1)
  m.save!
  add_pictures(m,i)
  m.save!
  puts "Member #{m.email} created with #{m.pictures.count} pictures"
end

1.upto 4 do |i|
  group = AdGroup.create! :name => "Group #{i}"
  1.upto 4 do |j|
    group.ads.create! :contents => "Ad #{j}"
  end
end

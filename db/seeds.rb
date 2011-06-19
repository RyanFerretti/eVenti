Location.create! :city => "Chicago", :state => "IL"
Location.create! :city => "New York", :state => "NY"
Location.create! :city => "Los Angeles", :state => "CA"

Role.create! :name => "admin"
Role.create! :name => "client"
Role.create! :name => "member"

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
  m.ratings.create(:value => (i%10)+1)
  m.ratings.create(:value => (i+1%10)+1)
  m.save!
  add_pictures(m,i)
  m.save!
  puts "Member #{m.email} created with #{m.pictures.count} pictures"
end

puts "Admin has #{Admin.first.roles.count} role called #{Admin.first.roles.first.name}"
puts "Client has #{Client.first.roles.count} role called #{Client.first.roles.first.name}"

1.upto 4 do |i|
  group = AdGroup.create! :name => "Group #{i}"
  1.upto 4 do |j|
    group.ads.create! :contents => "Ad #{j}"
  end
end

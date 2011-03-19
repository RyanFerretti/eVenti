Role.create! :name => "admin"
Role.create! :name => "client"
Role.create! :name => "member"

Admin.create! :email => "admin@gmail.com", :username => "admin", :password => "admin123", :password_confirmation => "admin123"
Member.create!:email => "member@gmail.com", :username => "member", :password => "member123", :password_confirmation => "member123", :confirmed_at => "2011-01-01 12:00:00", :confirmation_sent_at => "2011-01-01 11:00:00"
Client.create!:email => "client@gmail.com", :username => "client", :password => "client123", :password_confirmation => "client123", :confirmed_at => "2011-01-01 12:00:00", :confirmation_sent_at => "2011-01-01 11:00:00"


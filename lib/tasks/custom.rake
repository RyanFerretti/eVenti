namespace :db do
  desc "Runs db:migrate:reset and db:seed"
  task :nuke => ['db:migrate:reset','db:seed'] do
    puts "\nYou have been Nuked!"  
  end
end

#this must be run the in the next calender year since we subtract 1
namespace :app do
  desc "resets application for new year and new competition"
  task :reset => :environment do
    rejected = Member.where(:state => :rejected)
    pending = Member.where(:state => :pending)
    unsubscribed = Member.where(:state => :unsubscribed)
    members = Member.where(:state => :active).includes(:ratings)
    year = Date.today.year - 1

    puts "Found #{rejected.count} rejected members."
    puts "Found #{pending.count} pending members."
    puts "Found #{unsubscribed.count} unsubscribed members."
    puts "Found #{members.count} active members. Resetting for #{year}."
    
    Rating.transaction do
      members.each do |m|
        HistoricalRating.create(:member_id => m.id, :year => year, :total => m.average_rating)
        m.unsubscribe
        print "."
      end
      puts "Deleting all old votes"
      Rating.delete_all
    end

    unsubscribed = Member.where(:state => :unsubscribed)
    members = Member.where(:state => :active)
    puts "Now, there are #{unsubscribed.count} unsubscribed members."
    puts "Now, there are #{members.count} active members."
  end
end

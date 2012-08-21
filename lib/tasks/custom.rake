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
    members = Member.active
    year = Date.today.year - 1

    puts "Found #{rejected.count} rejected members."
    puts "Found #{pending.count} pending members."
    puts "Found #{unsubscribed.count} unsubscribed members."
    puts "Found #{members.count} active members. Resetting for #{year}."

    ratings = Rating.average(:value,:group => :member_id)
    member_ids = Member.active.select(:id).map{|m|m.id}

    inserts = []
    member_ids.each{|id| inserts.push("(#{id}, #{ratings[id].to_f}, #{year})")}
    sql = "INSERT INTO historical_ratings (member_id, total, year) VALUES #{inserts.join(", ")}"

    Member.active.update_all(:state => :unsubscribed)
    HistoricalRating.connection.execute sql
    Rating.delete_all

    unsubscribed = Member.where(:state => :unsubscribed)
    members = Member.active
    puts "Now, there are #{unsubscribed.count} unsubscribed members."
    puts "Now, there are #{members.count} active members."
  end
end

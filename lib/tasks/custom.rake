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
    members = Member.where(:state => :active).includes(:ratings)
    year = Date.today.year - 1
    puts "Found #{members.count} active members. Resetting"
    Rating.transaction do
      members.each do |m|
        HistoricalRating.create(:member_id => m.id, :year => year, :total => m.average_rating)
        m.unsubscribe
        puts "."
      end
      puts "Deleting all old votes"
      Rating.delete_all
    end
  end
end

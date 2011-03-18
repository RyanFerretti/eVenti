namespace :db do
  desc "Runs db:migrate:reset and db:seed"
  task :nuke => ['db:migrate:reset','db:seed'] do
    puts "\nYou have been Nuked!"  
  end
end
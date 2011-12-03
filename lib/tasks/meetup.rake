namespace :meetup do
  desc "Import and update the members list from Meetup.com"
  task :import_members => :environment do
    MeetupTasks.import_members
  end
end 

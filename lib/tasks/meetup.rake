namespace :meetup do
  desc "Import and update the members list from Meetup.com"
  task :import_members => :environment do
    Tokyorails::MeetupTasks.import_members
  end
end 

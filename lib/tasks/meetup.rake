namespace :meetup do
  desc "Import and update the members list from Meetup.com"
  task :import_members => :environment do
    Tokyorails::MeetupTasks.import_members
  end

  desc "Import and update the members list from Meetup.com"
  task :import_events => :environment do
    Tokyorails::MeetupTasks.import_events
  end
end

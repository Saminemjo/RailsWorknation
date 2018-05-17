desc 'This task is called by the Heroku scheduler add-on'
task update_feed: :environment do
  puts 'Updating feed...'
  NewsFeed.update
  puts 'done.'
end

task send_reminders: :environment do
  Request.registration_raise
  Request.set_to_expired
end
For app

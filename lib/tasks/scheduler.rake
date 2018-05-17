desc 'This task is called by the Heroku scheduler add-on'
task update_feed: :environment do
  puts 'Finding expired requests...'
  Request.set_to_expired
  puts 'done.'
end

task send_reminders: :environment do
  puts 'sending registration raise...'
  Request.registration_raise
  puts 'done.'
end

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
#set :output, "/log/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :chronic_options, hours24: true

every :day, :at => '09:00' do # Use any day of the week or :weekend,
    rake "email:send_email"
    runner "DigestMailMailer.new_email.deliver_now"
end

every 2.minutes do # Use any day of the week or :weekend,
    rake "email:send_email"
    #runner "DigestMailMailer.new_email.deliver_now"
    
    puts "email sent"
end

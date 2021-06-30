# frozen_string_literal: true

namespace :email do
  desc 'send digest email'
  task :send_email => [ :environment ] do
   # puts "email sent email."
    DigestMailMailer.new_email.deliver_now
  end
end



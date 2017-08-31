ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.sendmail_settings = {
  :location => '/usr/sbin/sendmail',
  :arguments => '-i',
  :user_name => 'christian.quentin@transparence-c.com',
  :password => 'wxcvb022'
}

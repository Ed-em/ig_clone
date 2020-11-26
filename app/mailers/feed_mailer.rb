class FeedMailer < ApplicationMailer
  def feed_mail(feed)
    @feed = feed
    mail to: "your email address", subject: "Inquiry confirmation email"
  end
end

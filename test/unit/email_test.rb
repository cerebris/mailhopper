require 'test_helper'

class EmailTest < ActiveSupport::TestCase
  context "An email" do
    setup do
      @email = Mailhopper::Email.new
    end

    should "require a from address" do
      assert !@email.valid?
      @email.from_address = 'user@example.com'
      assert @email.valid?
    end

    should "be generated when mail is sent" do
      headers = {
        :from => 'from@example.com',
        :to => 'to@example.com',
        :cc => 'cc@example.com',
        :bcc => 'bcc@example.com',
        :reply_to => 'reply_to@example.com',
        :subject => 'Hiya!'
      }
      content = 'Papaya'

      assert_equal Mailhopper::Email.count, 0
      SampleMailer.hello(headers, content).deliver
      assert_equal Mailhopper::Email.count, 1

      email = Mailhopper::Email.first

      assert_equal headers[:from],      email.from_address
      assert_equal headers[:to],        email.to_address
      assert_equal headers[:cc],        email.cc_address
      assert_equal headers[:bcc],       email.bcc_address
      assert_equal headers[:reply_to],  email.reply_to_address
      assert_equal headers[:subject],   email.subject

      # Email content will include headers as well as content
      assert email.content.include?(content)

      assert email.sent_at.nil?
    end
  end
end

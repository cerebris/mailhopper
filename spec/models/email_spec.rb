require 'spec_helper'

describe "Email" do
  let(:email) { Mailhopper::Email.new }

  it "should require a from address" do
    assert !email.valid?
    email.from_address = 'user@example.com'
    assert email.valid?
  end

  it "should be generated when mail is sent to individual addresses" do
    headers = {
      :from     => 'from@example.com',
      :to       => 'to@example.com',
      :cc       => 'cc@example.com',
      :bcc      => 'bcc@example.com',
      :reply_to => 'reply_to@example.com',
      :subject  => 'Hiya!'
    }
    content = 'Papaya'

    generate_and_verify_email(headers, content)
  end

  it "should be generated when mail is sent to multiple addresses" do
    headers = {
      :from     => 'from1@example.com',
      :to       => ['to1@example.com', 'to2@example.com'],
      :cc       => ['cc1@example.com', 'cc2@example.com'],
      :bcc      => ['bcc1@example.com', 'bcc2@example.com'],
      :reply_to => 'reply_to@example.com',
      :subject  => 'Hiya!'
    }
    content = 'Papaya'

    generate_and_verify_email(headers, content)
  end

  it "should be generated when mail is sent to blank addresses" do
    headers = {
      :from     => 'from@example.com',
      :to       => 'to@example.com',
      :cc       => nil,
      :bcc      => nil,
      :reply_to => nil,
      :subject  => 'Hiya!'
    }
    content = 'Papaya'

    generate_and_verify_email(headers, content)
  end
end

private

  def generate_and_verify_email(headers, content)
    assert_equal Mailhopper::Email.count, 0
    SampleMailer.hello(headers, content).deliver
    assert_equal Mailhopper::Email.count, 1

    email = Mailhopper::Email.first

    assert_email_matches_headers(headers, email)

    # Email content will include headers as well as content
    assert email.content.include?(content)

    assert email.sent_at.nil?
  end

  def assert_email_matches_headers(headers, email)
    assert_address_matches_header headers[:from],      email.from_address
    assert_address_matches_header headers[:to],        email.to_address
    assert_address_matches_header headers[:cc],        email.cc_address
    assert_address_matches_header headers[:bcc],       email.bcc_address
    assert_equal                  headers[:reply_to],  email.reply_to_address
    assert_equal                  headers[:subject],   email.subject
  end

  def assert_address_matches_header(header, address)
    if header.kind_of? Array
      assert_equal header.join(','), address
    else
      assert_equal header, address
    end
  end

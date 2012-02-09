class SampleMailer < ActionMailer::Base
  ActionMailer::Base.delivery_method = :mailhopper

  def hello(headers, content)
    @content = content
    mail(headers)
  end
end

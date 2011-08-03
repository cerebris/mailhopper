class SampleMailer < ActionMailer::Base
  ActionMailer::Base.delivery_method = :mailhopper

  default :from => "from@example.com"
end

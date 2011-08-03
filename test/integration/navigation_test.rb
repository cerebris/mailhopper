require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "truth" do
    assert_kind_of Dummy::Application, Rails.application
  end
end


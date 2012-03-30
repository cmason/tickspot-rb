require 'spec_helper'

describe Tickspot do

  before(:each) do
    Tickspot.company = nil
    Tickspot.email = nil
    Tickspot.password = nil
  end

  it "should be able to set the company" do
    Tickspot.company = 'acme'
    Tickspot.company.should == 'acme'
  end

  it "shoudl be able to set the email" do
    Tickspot.email = 'my_email@example.com'
    Tickspot.email.should == 'my_email@example.com'
  end

  it "should be able to set the password" do
    Tickspot.password = 'double_secret_probation'
    Tickspot.password.should == 'double_secret_probation'
  end
  it "should be able to set the company, email, and password via configuration block" do
    Tickspot.configure do |config|
      config.company  = 'acme'
      config.email    = 'my_email@example.com'
      config.password = 'double_secret_probation'
    end

    Tickspot.company.should  == 'acme'
    Tickspot.email.should    == 'my_email@example.com'
    Tickspot.password.should == 'double_secret_probation'
  end
end

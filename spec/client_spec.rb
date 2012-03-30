require 'spec_helper'

describe Tickspot::Client do
  describe "instantiation" do
    before(:each) do
      Tickspot.configure do |config|
        config.company = 'foo'
        config.email = 'foo@example.com'
        config.password = 'foo-secret'
      end
    end
    
    context "without arguments" do
      let (:client) { Tickspot::Client.new }
      it "uses credentials from Tickspot" do
        client.company.should == 'foo'
        client.email.should == 'foo@example.com'
        client.password.should == 'foo-secret'
      end
    end
    
    context "with arguments" do
      let (:client) { Tickspot::Client.new('bar', 'bar@example.com', 'bar-secret') }
      it "uses the passed in credentials" do
        client.company.should == 'bar'
        client.email.should == 'bar@example.com'
        client.password.should == 'bar-secret'
      end      
    end
  end
  
  describe "accessing API" do
    let (:client) { Tickspot::Client.new('bar', 'bar@example.com', 'bar-secret') }
    
    it "properly configures the base uri" do
      client.class.base_uri.should == 'https://bar.tickspot.com/api'
    end
    
    it "gets a list of clients" do
      fake_post("clients")
      results = client.clients
      results.should have(3).clients
      results.first.should be_an_instance_of(Hashie::Mash)
    end

    it "gets a list of users" do
      fake_post("users")
      results = client.users
      results.should have(3).users
      results.first.should be_an_instance_of(Hashie::Mash)
    end

    it "gets a list of projects" do
      fake_post("projects")
      results = client.projects
      results.should have(1).project
      results.first.should be_an_instance_of(Hashie::Mash)
    end

    it "gets a list of tasks" do
      fake_post("tasks", {:project_id => 42})
      results = client.tasks(:project_id => 42)
      results.should have(1).task
      results.first.should be_an_instance_of(Hashie::Mash)
    end

    it "gets a list of entries" do
      fake_post("entries", {:updated_at => "2012-03-29"})
      results = client.entries(:updated_at => "2012-03-29")
      results.should have(1).entry
      results.first.should be_an_instance_of(Hashie::Mash)
    end
  end
end

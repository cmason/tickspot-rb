require 'httparty'
require 'hashie'

module Tickspot

  class Client
    include HTTParty
    attr_reader :company, :email, :password

    def initialize(company = Tickspot.company, email = Tickspot.email, password = Tickspot.password)
      @company  = company
      @email    = email
      @password = password

      self.class.base_uri "https://#{@company}.tickspot.com/api"
    end
    # The clients method will return a list of all clients
    # and can only be accessed by admins on the subscription.
    #
    # Optional paramaters:
    #   open => [true|false]
    #
    def clients(options = {})
      post("/clients", options)["clients"].map {|obj| Hashie::Mash.new obj }
    end

    # The projects method will return projects filtered by the parameters provided.
    # Admin can see all projects on the subscription,
    # while non-admins can only access the projects they are assigned.
    #
    # Optional parameters:
    #   project_id
    #   open [true|false]
    #   project_billable [true|false]
    #
    def projects(options = {})
      post("/projects", options)["projects"].map {|obj| Hashie::Mash.new obj }
    end

    # The tasks method will return a list of all the current tasks for a specified project
    # and can only be accessed by admins on the subscription.
    #
    # Required parameters:
    #   project_id
    #
    # Optional Parameters:
    #   task_id
    #   open [true|false]
    #   task_billable [true|false]
    #
    def tasks(options = {})
      post("/tasks", options)["tasks"].map {|obj| Hashie::Mash.new obj }
    end

    # The method will return a list of all clients, projects, and tasks
    # that are assigned to the user and available for time entries (open).
    #
    def clients_projects_tasks
      post("/clients_projects_tasks")["clients"].map {|obj| Hashie::Mash.new obj }
    end

    # The entries method will return a list of all entries that meet the provided criteria.
    # Either a start and end date have to be provided or an updated_at time.
    # The entries will be in the start and end date range or they will be after
    # the updated_at time depending on what criteria is provided.
    # Each of the optional parameters will further filter the response.
    #
    # Required parameters:
    #   start_date
    #   end_date
    # OR
    #  updated_at
    #
    # Optional Parameters:
    #   project_id
    #   task_id
    #   user_id
    #   user_email
    #   client_id
    #   entry_billable [true|false]
    #   billed [true|false]
    #
    def entries(options = {})
      post("/entries", options)["entries"].map {|obj| Hashie::Mash.new obj }
    end

    # The users method will return a list of the most recently used tasks.
    # This is useful for generating quick links for a user to select a task they have been using recently.
    #
    def recent_tasks
      post("/recent_tasks")['recent_tasks'].map {|obj| Hashie::Mash.new obj }
    end

    # The users method will return a list of users.
    #
    # Optional parameters:
    #   project_id
    #
    def users(options = {})
      post("/users", options)['users'].map {|obj| Hashie::Mash.new obj }
    end

    # The create_entry method will accept a time entry for a specified task_id
    # and return the created entry along with the task and project stats.
    #
    # Require parameters:
    #   task_id
    #   hours
    #   date
    #
    # Optional parameters:
    #   notes
    #
    def create_entry(options = {})
      post("/create_entry", options)
    end

    # The update_entry method will allow you to modify attributes of an existing entry.
    # The only required parameter is the id of the entry.
    # Additional parameters must be provided for any attribute that you wish to update.
    # For example, if you are only changing the billed attribute,
    # your post should only include the required parameters and the billed parameter.
    #
    # Require parameters:
    #   id
    #
    # Optional parameters:
    #   hours
    #   date
    #   billed
    #   task_id
    #   user_id
    #   notes
    #
    def update_entry(options = {})
      post("/update_entry", options)
    end

    private
    def post(path, options={})
      self.class.post(path, :query => options.merge!(:email => @email, :password => @password))
    end
  end
end

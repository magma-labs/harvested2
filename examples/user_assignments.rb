require "harvested"

subdomain = 'yoursubdomain'
username = 'userusername'
password = 'yourpassword'

harvest = Harvest.hardy_client(subdomain: subdomain, username: username, password: password)

# Create a Client, Project, and a User then assign that User to that Project

client = Harvest::Client.new(name: 'SuprCorp')
client = harvest.clients.create(client)

project = Harvest::Project.new(name: 'SuprGlu', client_id: client.id, notes: 'Some notes about this project')
project = harvest.projects.create(project)

harvest.projects.create_task(project, 'Bottling Glue')

user = Harvest::User.new(first_name: 'Jane', last_name: 'Doe', email: 'jane@doe.com', timezone: :est, password: 'secure')
user = harvest.users.create(user)

user_project_assignment = Harvest::UserProjectAssignment.new(user_id: user.id)
harvest.user_project_assignments.create(user_project_assignment)
puts 'Assigned Jane Doe to the project "SuprGlu"'

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'csv'

csv_text = File.read('./tmp/appt_data.csv')
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  Appointment.create!(row.to_hash)
end

Rails.application.load_tasks

require 'csv'

namespace :import_appointments_csv do
  task :create_appointments => :environment do
    csv_text = File.read('appt_data.csv')
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Appointment.create!(row.to_hash)
    end
  end
end


namespace :import_appointments_csv do
  task :create_appointments => :environment do
    require 'csv'
    csv_text = File.read(Rails.root.join('tmp', 'appt_data.csv'))
    
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Appointment.create!(row.to_hash)
    end
  end
end

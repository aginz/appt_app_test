
def format_time(old_time)
  DateTime.strptime(old_time, "%m/%d/%y %k:%M")
end

def params_from_row(row)
  {
    start_time: format_time(row[0]),
    end_time: format_time(row[1]),
    first_name: row[2],
    last_name: row[3],
    comments: row[4]
  }
end

namespace :import_appointments_csv do
  task :create_appointments => :environment do
    require 'csv'
    csv_text = File.read(Rails.root.join('data', 'appt_data.csv'))
    
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Appointment.where(start_time: format_time(row[0]).to_s).first_or_create!(params_from_row(row))
    end
  end
end

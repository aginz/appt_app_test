1. Read in the original file using CSV
2. Figure out what the format of the dates actually is: 11/6/13 9:15
3. Create a conversion method, convert_time
    def convert_time(old_time)
     # DateTime.strptime("11/6/13 9:15", "%m/%d/%y %k:%M")
     DateTime.strptime(old_time, "%m/%d/%y %k:%M")
    end

lines.each do |row|
  appt = Appointment.where().first_or_initialize
  appt.update_attributes = params_from_row(row)
  appt.save
end

def params_from_row(row)
  {
    start_time: convert_time(row[0]),
    end_time: convert_time(row[1]),
    name: row[2],
    mail: row[3]
  }

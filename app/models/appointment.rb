class Appointment < ActiveRecord::Base
  validates :start_time, :end_time, :first_name, :last_name, presence: true
  validate :appointment_cannot_be_in_the_past, on: :create
  validate :appointment_cannot_be_in_the_past, on: :update


  def appointment_cannot_be_in_the_past
    start_time = format_time(:start_time)
    puts "=====PRINTING START TIME ======"
    p "#{start_time}"
    if start_time < Time.now
      errors.add(:start_time, "can't be in the past")
    end 
  end
end

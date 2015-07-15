class Appointment < ActiveRecord::Base
  validates :start_time, :end_time, :first_name, :last_name, presence: true
  # validate :appointment_cannot_be_in_the_past, on: :create
  # validate :appointment_cannot_be_in_the_past, on: :update
  # validate :appointment_cannot_exist, on: :create
  # validate :appointment_cannot_exist, on: :update

  def appointment_cannot_be_in_the_past
    appointment_time = format_time(@appointment.start_time)

    if appointment_time < Time.now
      errors.add(:start_time, "can't be in the past")
    end 
  end

  # Uniqueness validation
  # must_be_unique
  def appointment_cannot_exist
    appointment_time = @appointment.start_time
    if Appointment.find_by(start_time: appointment_time).start_time == appointment_time
      errors.add(:start_time, "appointment already exists")
    end
  end
end

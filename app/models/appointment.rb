class Appointment < ActiveRecord::Base
  validates :start_time, :end_time, :first_name, :last_name, presence: true
  validate :appointment_cannot_be_in_the_past, :appointment_cannot_exist, on: :create
  validate :appointment_cannot_be_in_the_past, :appointment_connot_exist, on: :update

  private
  def appointment_cannot_be_in_the_past
    appointment_time = format_time(:start_time)

    if appointment_time < Time.now
      errors.add(:start_time, "can't be in the past")
    end 
  end

  def appointment_cannot_exist
    appointment_time = :start_time
    if Appointment.find_by(start_time: appointment_time) == !nil
      errors.add(:start_time, "appointment already exists")
    end
  end
end

class Appointment < ActiveRecord::Base
  validates :start_time, :end_time, :first_name, :last_name, presence: true
  validates :start_time, :end_time, uniqueness: true
  
  # validate :appointment_cannot_be_in_the_past, on: :create
  # validate :appointment_cannot_be_in_the_past, on: :update
  # validate :appointment_cannot_exist, on: :create
  # validate :appointment_cannot_exist, on: :update

  private
  def start_time_is_datetime
    DateTime.parse(start_time).is_a?(DateTime)
  end

  def appointment_cannot_be_in_the_past
    if start_time < DateTime.now
      errors.add(:start_time, "can't be in the past")
    end 
  end

  # Uniqueness validation
  # must_be_unique
  # def appointment_cannot_exist
    # appointment_time = @appointment.start_time
    # if Appointment.find_by(start_time: appointment_time).start_time == appointment_time
      # errors.add(:start_time, "appointment already exists")
    # end
  # end
end

class Appointment < ActiveRecord::Base
  validates :start_time, :end_time, :first_name, :last_name, presence: true
  validates :start_time, :end_time, uniqueness: true
  validate :appointment_cannot_be_in_the_past
  validate :end_time_cannot_be_before_start_time

  private
  def appointment_cannot_be_in_the_past
    if start_time < DateTime.now
      errors.add(:start_time, "can't be in the past")
    end 
  end

  def end_time_cannot_be_before_start_time
    if start_time > end_time
      errors.add(:end_time, "can't be before the start time")
    end
  end
end

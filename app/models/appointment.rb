class Appointment < ActiveRecord::Base
  validates :start_time, :end_time, :first_name, :last_name, presence: true
end


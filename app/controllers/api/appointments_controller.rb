module Api
  class AppointmentsController < ApplicationController
    def index
      appointments = Appointment.all
      if start_time = params[:start_time]
        start_time = format_time(start_time)
        appointments = appointments.where(start_time: start_time.beginning_of_day..start_time.end_of_day )
      end
      render json: appointments, status: 200
    end
  end
end

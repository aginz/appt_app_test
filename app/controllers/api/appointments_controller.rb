module Api
  class AppointmentsController < ApplicationController
    def index
      appointments = Appointment.all
      if start_time = params[:start_time]
        start_time = format_time(start_time)
        beg_day = start_time.beginning_of_day
        end_day = start_time.end_of_day
        appointments = Appointment.where(start_time: string_time(beg_day)..string_time(end_day))
      end
      render json: appointments, status: 200
    end

    def show
      appointment = Appointment.find(params[:id])
      render json: appointment, status: 200
    end
  end
end

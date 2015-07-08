class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.all
    respond_to do |format|
      format.json { render json: @appointments }
    end
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      render json: @appointment, status: 201, location: @appointment
    else
      render json: @appointment.errors, status: 422
    end
  end

  private
    def appointment_params
      params.require(:appointment).permit(:start_time, :end_time, :first_name, :last_name, :comments)
    end
end

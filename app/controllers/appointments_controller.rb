class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:update, :destroy]
  
  def index
    @appointments = Appointment.all
    respond_to do |format|
      format.json { render json: @appointments }
    end
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      # head :no_content, location: @appointment
      render json: @appointment, status: :created, location: @appointment
    else
      render json: @appointment.errors, status: 422
    end
  end

  def update
    if @appointment.update(appointment_params)
      render json: @appointment, status: 200
    else
      render json: @appointment.errors, status: 422
    end
  end

  def destroy
    @appointment.destroy
    head 204
  end

  private
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end  
    def appointment_params
      params.require(:appointment).permit(:start_time, :end_time, :first_name, :last_name, :comments)
    end
end

class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:update, :destroy]
  
  def index
    if start_time = params[:start_time]
      start_time = format_time(start_time)
      beg_day = start_time.beginning_of_day
      end_day = start_time.end_of_day
      @appointments = Appointment.where(start_time: string_time(beg_day)..string_time(end_day))
    else     
      @appointments = Appointment.all
    end
    
    respond_to do |format|
      format.json { render json: @appointments } 
      format.html { render html: @appointments }
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

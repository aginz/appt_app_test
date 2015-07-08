class AppointmentsController < ApplicationController
  def index
    appointments = Appointment.all
    
    respond_to do |format|
      format.json { render json: appointments, status: 200 }
    end
  end
end

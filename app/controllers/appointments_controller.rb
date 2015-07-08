class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.all
    respond_to do |format|
      format.json
      format.html
    end
  end
end

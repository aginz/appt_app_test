class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  #Converts to DateTime object from string
  def convert_time_from_string(old_time)
    DateTime.parse(old_time) 
  end
end

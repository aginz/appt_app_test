class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  # def format_url_time(time)
    # time.include?('%20') ? time.gsub('%20', ' ') : time #Convert URL query to proper format
    # convert_time(time)
  # end

  def convert_time_from_string(old_time)
    DateTime.parse(old_time) #Converts to DateTime object
  end

  # def string_time(time)
    # time.strftime("%m/%e/%y %k:%M") #Convert time to string format mm/dd/yy
  # end  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def format_time(time)
    time.include?('%20') ? time.gsub('%20', ' ') : time #Convert URL query to proper format
    Time.strptime(time, "%m/%e/%y %k:%M") #Converts string mm/dd/yy to time format
  end

  def string_time(time)
    time.strftime("%m/%e/%y %k:%M") #Convert time to string format mm/dd/yy
  end  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
end

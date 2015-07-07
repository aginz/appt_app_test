class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :format_time

  def format_time(time)
    time.include?('%20') ? time.gsub('%20', ' ') : time
    Time.strptime(time, "%m/%d/%y %H:%M") #Converts string mm/dd/yy to time format
  end
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
end

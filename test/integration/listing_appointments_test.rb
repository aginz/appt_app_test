require 'test_helper'

class ListingAppointmentsTest < ActionDispatch::IntegrationTest
  test 'returns list of all appointments' do
    get '/appointments'
    assert_equal 200, response.status
    refute_empty response.body
  end

  test 'returns appointments filtered by start_time' do
    jack = Appointment.create!(start_time: "2015-11-01T09:00:00+00:00", end_time: "2015-11-01T09:05:00+00:00", first_name: 'Jack', last_name: 'Example', comments: '')
    jill = Appointment.create!(start_time: "2015-12-01T09:00:00+00:00", end_time: "2015-12-01T09:05:00+00:00", first_name: 'Jill', last_name: 'Example', comments: '')

    get "/appointments?start_time=2015-11-01T09:00:00+00:00"
    assert_equal 200, response.status

    appointments = JSON.parse(response.body)
    first_names = appointments.collect { |a| a["first_name"] }
    assert_includes first_names, 'Jack'
    refute_includes first_names, 'Jill'
  end
  
  test 'returns appointment by id' do
    appointment = Appointment.create!(start_time: "2015-11-01T09:00:00+00:00", end_time: "2015-11-01T09:05:00+00:00", first_name: 'Jack', last_name: 'Example', comments: '')
    
    get "/appointments/#{appointment.id}"
    assert_equal 200, response.status

    appt_response = JSON.parse(response.body)
    assert_equal appointment.first_name, appt_response["first_name"]
  end

  test 'returns appointment in JSON' do
    get '/appointments'
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end
end

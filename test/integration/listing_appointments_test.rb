require 'test_helper'

class ListingAppointmentsTest < ActionDispatch::IntegrationTest
  setup { host! 'api.appt-test.dev' }

  test 'returns list of all appointments' do
    get '/appointments'
    assert_equal 200, response.status
    refute_empty response.body
  end

  test 'returns appointments filtered by start_time' do
    test_appt1 = Appointment.create!(start_time: '11/11/15 9:00', end_time: '11/11/15 9:30', first_name: 'nov_test', last_name: 'nov_example', comments: '')
    test_appt2 = Appointment.create!(start_time: '10/11/15 10:00', end_time: '10/11/15 10:30', first_name: 'oct_test', last_name: 'oct_example', comments: '')

    get '/appointments?start_time=11/11/15 9:00'
    assert_equal 200, response.status

    appointments = json(response.body)
    first_names = appointments.collect { |a| a[:first_name] }
    assert_includes first_names, 'nov_test'
    refute_includes first_names, 'oct_test'
  end
  
  test 'returns appointment by id' do
    appointment = Appointment.create!(start_time: '11/11/15 9:00', end_time: '11/11/15 9:30', first_name: 'nov_test', last_name: 'nov_example', comments: '')
    
    get "/appointments/#{appointment.id}"
    assert_equal 200, response.status

    appt_response = json(response.body)
    assert_equal appointment.first_name, appt_response[:first_name] 
  end
end

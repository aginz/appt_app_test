class CreatingAppointmentsTest < ActionDispatch::IntegrationTest
  
  setup { @appointment = Appointment.create!(start_time: "2016-01-01T09:00:00+00:00", end_time: "2016-01-01T09:05:00+00:00", first_name: "Harry", last_name: "Potter") }
  
  test 'creates appointments' do
    post '/appointments',
      { appointment:
        { start_time: "2016-12-01T09:00:00+00:00", end_time: "2016-12-01T09:05:00+00:00", first_name: "Jack", last_name: "Example", comments: "" }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type

    appointment = JSON.parse(response.body, symbolize_names: true)
    assert_equal appointment_url(appointment[:id]), response.location
  end

  test 'does not create appointments with start time in past' do
    post '/appointments',
      { appointment:
        { start_time: "2014-01-01T09:00:00+00:00", end_time: "2014-01-01T09:05:00+00:00", first_name: "Jack", last_name: "Example", comments: "" }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
    
    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end

  test 'does not create appointment with start time that already exists' do
    post '/appointments',
      { appointment:
        { start_time: "2016-01-01T09:00:00+00:00", end_time: "2016-01-01T09:05:00+00:00", first_name: "Harry", last_name: "Potter", comments: "" }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end
  
  test 'does not create appointments where end time is less than start time' do
    post '/appointments',
      { appointment:
        { start_time: "2016-02-01T08:10:00+00:00", end_time: "2016-02-01T08:05:00+00:00", first_name: "Harry", last_name: "Potter", comments: "" }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end
end

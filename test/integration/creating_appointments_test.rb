class CreatingAppointmentsTest < ActionDispatch::IntegrationTest
  
  setup { @appointment = Appointment.create!(start_time: "11/12/15 9:00", end_time: "11/12/15 9:30", first_name: "Harry", last_name: "Potter") }
  
  test 'creates appointments' do
    post '/appointments',
      { appointment:
        { start_time: "1/1/15 9:00", end_time: "1/1/15 9:30", first_name: "Jack", last_name: "Example", comments: "" }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type

    appointment = JSON.parse(response.body, symbolize_names: true)
    assert_equal appointment_url(appointment[:id]), response.location
  end
  
  test 'does not create appointments with nil start_time' do
    post '/appointments',
      { appointment:
        { start_time: nil, end_time: "1/1/16 9:05", first_name: "Jack", last_name: "Example", comments: "" }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type 
  end

  test 'does not create appointments with nil end_time' do
    post '/appointments',
      { appointment:
        { start_time: "1/1/16 9:00", end_time: nil, first_name: "Jack", last_name: "Example", comments: "" }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type 
  end

  test 'does not create appointments with nil first_name' do
    post '/appointments',
      { appointment:
        { start_time: "1/1/16 9:00", end_time: "1/1/16 9:05", first_name: nil, last_name: "Example", comments: "" }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type 
  end
  
  test 'does not create appointments with nil last_name' do
    post '/appointments',
      { appointment:
        { start_time: "1/1/16 9:00", end_time: "1/1/16 9:05", first_name: "Jack", last_name: nil, comments: "" }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type 
  end
  
  test 'does not create appointments with start time in past' do
    post '/appointments',
      { appointment:
        { start_time: "1/1/14 9:00", end_time: "1/1/14 9:05", first_name: "Jack", last_name: "Example", comments: "" }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end

  test 'does not create appointment with start time that already exists' do
    post '/appointments',
      { appointment:
        { start_time: "11/12/15 9:00", end_time: "11/12/15 9:30", first_name: "Harry", last_name: "Potter", comments: "" }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end
end

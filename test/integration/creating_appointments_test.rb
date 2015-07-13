class CreatingAppointmentsTest < ActionDispatch::IntegrationTest
  
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

  test 'does not create appointments with start time in past' do
    post '/appointments',
      { appointment:
        { start_time: "1/1/14 9:00", end_time: "1/1/14 9:05", first_name: "Jack", last_name: "Example", comments: "" }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 422, response.status
    appointment = JSON.parse(response.body, symbolize_names: true)
    p "#{appointment}"
    assert_equal Mime::JSON, response.content_type
  end
end

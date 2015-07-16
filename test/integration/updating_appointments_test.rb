class UpdatingAppointmentsTest < ActionDispatch::IntegrationTest
  setup { @appointment = Appointment.create!(start_time: "2016-01-01T09:00:00+00:00", end_time: "2016-01-01T09:05:00+00:00", first_name: "Harry", last_name: "Potter") }
 
  test 'successful update' do
   p "Before patch: #{@appointment}"
   patch "/appointments/#{@appointment.id}",
   { appointment: {start_time: "2016-12-01T09:00:00+00:00", end_time: "2016-12-01T09:05:00+00:00" } }.to_json,
   { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
   
   assert_equal 200, response.status
   assert_equal "2016-12-01T09:00:00+00:00",  @appointment.reload.start_time
   assert_equal "2016-12-01T09:05:00+00:00", @appointment.reload.end_time
  end
end

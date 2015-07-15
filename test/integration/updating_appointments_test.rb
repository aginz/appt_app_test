class UpdatingAppointmentsTest < ActionDispatch::IntegrationTest
  setup { @appointment = Appointment.create!(start_time: "11/12/16 9:00", end_time: "11/12/16 9:30", first_name: "Harry", last_name: "Potter") }
 
  test 'successful update' do
   p "Before patch: #{@appointment}"
   patch "/appointments/#{@appointment.id}",
   { appointment: {start_time: "10/31/16 9:00", end_time: "10/31/16 9:30" } }.to_json,
   { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
   
   assert_equal 200, response.status
   assert_equal "10/31/15 9:00", @appointment.reload.start_time
   assert_equal "10/31/15 9:30", @appointment.reload.end_time
  end
end

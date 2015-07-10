class DeletingAppointmentsTest < ActionDispatch::IntegrationTest
  setup { @appointment = Appointment.create!(start_time: "12/31/15 9:00", end_time: "12/31/15 9:30", first_name: "Delete", last_name: "Me") }

  test 'deleting existing appointment' do
    delete "/appointments/#{@appointment.id}"
    assert_equal 204, response.status
  end
end

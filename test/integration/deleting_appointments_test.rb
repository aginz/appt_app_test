class DeletingAppointmentsTest < ActionDispatch::IntegrationTest
  setup { @appointment = Appointment.create!(start_time: "2015-11-01T09:00:00+00:00", end_time: "2015-11-01T09:05:00+00:00", first_name: "Delete", last_name: "Me") }

  test 'deleting existing appointment' do
    delete "/appointments/#{@appointment.id}"
    assert_equal 204, response.status
  end
end

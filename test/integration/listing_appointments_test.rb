require 'test_helper'

class ListingAppointmentsTest < ActionDispatch::IntegrationTest
  setup { host! 'api.appt-test.dev' }

  test 'returns list of all appointments' do
    get '/appointments'
    assert_equal 200, response.status
    refute_empty response.body
  end
end

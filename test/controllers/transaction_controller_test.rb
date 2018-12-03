require 'test_helper'

class TransactionControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get transaction_new_url
    assert_response :success
  end

end

require 'test_helper'

class UploadingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get uploading_index_url
    assert_response :success
  end

end

require 'test_helper'

class AttachmentControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get attachment_index_url
    assert_response :success
  end

end

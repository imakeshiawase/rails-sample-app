require 'test_helper'

class TrackImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get track_images_index_url
    assert_response :success
  end

  test "should get new" do
    get track_images_new_url
    assert_response :success
  end

  test "should get edit" do
    get track_images_edit_url
    assert_response :success
  end

end

require 'test_helper'

class MarketingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @marketing = marketings(:one)
  end

  test "should get index" do
    get marketings_url
    assert_response :success
  end

  test "should get new" do
    get new_marketing_url
    assert_response :success
  end

  test "should create marketing" do
    assert_difference('Marketing.count') do
      post marketings_url, params: { marketing: { content: @marketing.content, lead_id: @marketing.lead_id, product_id: @marketing.product_id, result: @marketing.result, source_id: @marketing.source_id, time: @marketing.time } }
    end

    assert_redirected_to marketing_url(Marketing.last)
  end

  test "should show marketing" do
    get marketing_url(@marketing)
    assert_response :success
  end

  test "should get edit" do
    get edit_marketing_url(@marketing)
    assert_response :success
  end

  test "should update marketing" do
    patch marketing_url(@marketing), params: { marketing: { content: @marketing.content, lead_id: @marketing.lead_id, product_id: @marketing.product_id, result: @marketing.result, source_id: @marketing.source_id, time: @marketing.time } }
    assert_redirected_to marketing_url(@marketing)
  end

  test "should destroy marketing" do
    assert_difference('Marketing.count', -1) do
      delete marketing_url(@marketing)
    end

    assert_redirected_to marketings_url
  end
end

require 'test_helper'

class SalesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sale = sales(:one)
  end

  test "should get index" do
    get sales_url
    assert_response :success
  end

  test "should get new" do
    get new_sale_url
    assert_response :success
  end

  test "should create sale" do
    assert_difference('Sale.count') do
      post sales_url, params: { sale: { connection: @sale.connection, customer: @sale.customer, demand: @sale.demand, email: @sale.email, modified_time: @sale.modified_time, phone: @sale.phone, product_id: @sale.product_id, sale_lead_id: @sale.sale_lead_id, status_id: @sale.status_id, time: @sale.time } }
    end

    assert_redirected_to sale_url(Sale.last)
  end

  test "should show sale" do
    get sale_url(@sale)
    assert_response :success
  end

  test "should get edit" do
    get edit_sale_url(@sale)
    assert_response :success
  end

  test "should update sale" do
    patch sale_url(@sale), params: { sale: { connection: @sale.connection, customer: @sale.customer, demand: @sale.demand, email: @sale.email, modified_time: @sale.modified_time, phone: @sale.phone, product_id: @sale.product_id, sale_lead_id: @sale.sale_lead_id, status_id: @sale.status_id, time: @sale.time } }
    assert_redirected_to sale_url(@sale)
  end

  test "should destroy sale" do
    assert_difference('Sale.count', -1) do
      delete sale_url(@sale)
    end

    assert_redirected_to sales_url
  end
end

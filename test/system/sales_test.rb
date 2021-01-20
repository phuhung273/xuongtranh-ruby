require "application_system_test_case"

class SalesTest < ApplicationSystemTestCase
  setup do
    @sale = sales(:one)
  end

  test "visiting the index" do
    visit sales_url
    assert_selector "h1", text: "Sales"
  end

  test "creating a Sale" do
    visit sales_url
    click_on "New Sale"

    fill_in "Connection", with: @sale.connection
    fill_in "Customer", with: @sale.customer
    fill_in "Demand", with: @sale.demand
    fill_in "Email", with: @sale.email
    fill_in "Modified time", with: @sale.modified_time
    fill_in "Phone", with: @sale.phone
    fill_in "Product", with: @sale.product_id
    fill_in "Sale lead", with: @sale.sale_lead_id
    fill_in "Status", with: @sale.status_id
    fill_in "Time", with: @sale.time
    click_on "Create Sale"

    assert_text "Sale was successfully created"
    click_on "Back"
  end

  test "updating a Sale" do
    visit sales_url
    click_on "Edit", match: :first

    fill_in "Connection", with: @sale.connection
    fill_in "Customer", with: @sale.customer
    fill_in "Demand", with: @sale.demand
    fill_in "Email", with: @sale.email
    fill_in "Modified time", with: @sale.modified_time
    fill_in "Phone", with: @sale.phone
    fill_in "Product", with: @sale.product_id
    fill_in "Sale lead", with: @sale.sale_lead_id
    fill_in "Status", with: @sale.status_id
    fill_in "Time", with: @sale.time
    click_on "Update Sale"

    assert_text "Sale was successfully updated"
    click_on "Back"
  end

  test "destroying a Sale" do
    visit sales_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Sale was successfully destroyed"
  end
end

require "helper"

describe "Menu" do
  before(:all) do
    response = signin(USER)
    data = ActiveSupport::HashWithIndifferentAccess.new(**JSON.parse(response.body))
    @token = data[:token]
  end

  it "Main List" do
    response = HTTP.auth("Bearer #{@token}").get(MENU_LIST_URL)
    data = JSON.parse(response.body).collect { |i| ActiveSupport::HashWithIndifferentAccess.new(i) }
    expect(data).not_to be_nil
    # puts data
    @first_menu = data[0]
    # puts @first_menu
    expect(@first_menu).not_to be_nil
    expect(@first_menu[:is_active]).to be_truthy
    expect(@first_menu[:name]).to eq("ออกแบบสถาปัตย์")
    expect(@first_menu).to include(:icon)
    expect(@first_menu).to include(:display_seq)
  end
end
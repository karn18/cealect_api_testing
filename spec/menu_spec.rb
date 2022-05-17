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

  it "Sub Menu List" do
    first_menu_id = "849ad8dd-9f79-4fc7-8085-fda7f42c1b38"
    # puts "#{SUB_MENU_LIST_URL}/#{first_menu_id}/"
    response = HTTP.auth("Bearer #{@token}").get("#{SUB_MENU_LIST_URL}/#{first_menu_id}/")
    data = JSON.parse(response.body).collect { |i| ActiveSupport::HashWithIndifferentAccess.new(i) }
    puts data
    expect(data).not_to be_nil
    
    @first_sub_menu = data[0]
    puts @first_sub_menu[:id]
    expect(@first_sub_menu).not_to be_nil
    expect(@first_sub_menu[:is_active]).to be_truthy
    expect(@first_sub_menu[:name]).to eq("บ้านพักอาศัย")
    expect(@first_sub_menu).to include(:icon)
    expect(@first_sub_menu).to include(:display_seq)
  end

  it "Service Menu List" do
    first_menu_id = "8a1fcb16-6072-42d8-b7f6-f25d46d0d3bb"
    # puts "#{SERVICE_MENU_LIST_URL}#{first_menu_id}/"
    response = HTTP.auth("Bearer #{@token}").get("#{SERVICE_MENU_LIST_URL}#{first_menu_id}/")
    data = JSON.parse(response.body).collect { |i| ActiveSupport::HashWithIndifferentAccess.new(i) }
    puts data
    expect(data).not_to be_nil
    
    @service = data[0]
    expect(@service).not_to be_nil
    expect(@service[:is_active]).to be_truthy
    expect(@service[:name]).to eq("ปรึกษางานออกแบบเบื้องต้น")
    expect(@service).to include(:icon)
    expect(@service).to include(:display_seq)
    expect(@service[:description]).to be_nil
  end
end
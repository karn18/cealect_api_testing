require "helper"

describe "Technician" do
  before(:all) do
    response = signin(TECHNICIAN)
    data = ActiveSupport::HashWithIndifferentAccess.new(**JSON.parse(response.body))
    @token = data[:token]
    @user = data[:user]
  end

  it "Update user info" do
    response = HTTP.auth("Bearer #{@token}").put("#{TECHNICIAN_URL}#{@user[:id]}/", form: {
      first_name: "กานต์",
      id_card: "1839900007515",
      technician_type: "OP",
      bank: "004",
      bank_account: "123432345341",
      address_detail: "79/27",
      province: "00000000-0000-0000-0000-000000000042",
      district: "00000000-0000-0000-0000-000000000370",
      sub_district: "00000000-0000-0000-0000-0000000caa97",
      profile_picture: HTTP::FormData::File.new("./image.png")  
    })

    puts response.inspect
    puts response.body

    data = ActiveSupport::HashWithIndifferentAccess.new(**JSON.parse(response.body))
    
    expect(response.status).to eq(200)
    expect(data[:first_name]).to eq("กานต์")
    expect(data[:profile_picture]).not_to be_nil
  end

  skip "Role list" do
    response = HTTP.auth("Bearer #{@token}").get(TECHNICIAN_ROLE_LIST)
    puts response
    expect(response.status).to eq(200)
    data = JSON.parse(response.body).collect { |i| ActiveSupport::HashWithIndifferentAccess.new(i) }
    expect(data).not_to be_nil
    # expect(@first_menu[:is_active]).to be_truthy
  end
end

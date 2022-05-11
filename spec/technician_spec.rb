require "helper"

describe "Technician" do
  before(:all) do
    response = signin(TECHNICIAN)
    data = ActiveSupport::HashWithIndifferentAccess.new(**JSON.parse(response.body))
    @token = data[:token]
    @user = data[:user]
  end

  it "Update user info" do
    response = HTTP.auth("Bearer #{@token}").patch("#{TECHNICIAN_URL}#{@user[:id]}/", form: {
      first_name: "กานต์",
      profile_picture: HTTP::FormData::File.new("./image.png")  
    })
    data = ActiveSupport::HashWithIndifferentAccess.new(**JSON.parse(response.body))
    expect(response.status).to eq(200)
    expect(data[:first_name]).to eq("กานต์")
    expect(data[:profile_picture]).not_to be_nil
  end
end

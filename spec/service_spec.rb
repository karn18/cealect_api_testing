require "helper"

describe "User Service" do
  before(:all) do
    response = signin(USER)
    data = ActiveSupport::HashWithIndifferentAccess.new(**JSON.parse(response.body))
    @token = data[:token]
    @user = data[:user]
  end

  it "Create service request" do
    service = {
      location: {
        latitude: "7.957314",
        longitude: "98.376387"
      },
      customer: @user[:id],
      service: "20acff3e-7e79-4fd2-8a5b-af081218e16e"
    }
    # service = ปรึกษางานเบื้องต้น

    response = HTTP.auth("Bearer #{@token}").post("#{SERVICE_REQUEST_URL}", json: service)
    puts response.inspect
    puts response.status
    expect(response.status).to eq(201)
    
    data = ActiveSupport::HashWithIndifferentAccess.new(**JSON.parse(response.body))
    expect(data[:id]).not_to be_nil
    expect(data[:location][:latitude].to_s).to eq(service[:location][:latitude])
  end
end

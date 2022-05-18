require "helper"

describe "Customer Service" do
  before(:all) do
    response = signin(USER)
    data = ActiveSupport::HashWithIndifferentAccess.new(**JSON.parse(response.body))
    @token = data[:token]
    @user = data[:user]
  end

  skip "Create service request" do
    service = {
      location: {
        latitude: "7.957314",
        longitude: "98.376387"
      },
      location_description: "บ้านอยู่ใกล้เซเว่นมั้ง",
      description: "อยากซ่อมแซมพื้นบ้านโดยรอบบ้าน",
      customer: @user[:id],
      service: "20acff3e-7e79-4fd2-8a5b-af081218e16e"
    }
    # service = ปรึกษางานเบื้องต้น

    response = HTTP.auth("Bearer #{@token}").post("#{SERVICE_REQUEST_URL}", json: service)
    # puts response.inspect
    # puts response.status
    expect(response.status).to eq(201)
    
    data = ActiveSupport::HashWithIndifferentAccess.new(**JSON.parse(response.body))
    expect(data[:id]).not_to be_nil
    expect(data[:location][:latitude].to_s).to eq(service[:location][:latitude])
  end

  it "Upload image for request service" do
    service_id = "01f5b524-4437-40a1-9007-9fa38e230b88"
    response = HTTP.auth("Bearer #{@token}").post("#{CREATE_IMAGE_FOR_SERVICE_URL}", form: {
      service_request: service_id,
      image: HTTP::FormData::File.new("./image.png")  
    })

    data = ActiveSupport::HashWithIndifferentAccess.new(**JSON.parse(response.body))
    expect(data[:id]).not_to be_nil
    expect(data[:image]).not_to be_nil
    expect(data[:service_request])).to eq(service_id)
  end

  it "Get technician for service" do
    service_id = "01f5b524-4437-40a1-9007-9fa38e230b88"
    # puts "#{TECHINCIAN_FOR_SERVICE_URL}#{service_id}/"
    response = HTTP.auth("Bearer #{@token}").get("#{TECHINCIAN_FOR_SERVICE_URL}#{service_id}/")
    # puts response.inspect
    # puts response.status
    expect(response.status).to eq(200)
  end

  it "Select technician for service" do
    service_id = "01f5b524-4437-40a1-9007-9fa38e230b88"
    data = {
      technician_list: [ 'b8907287-a7ee-484f-af4e-4eddd927dcd1', '749fe6b5-b99c-4fed-a5ca-2ddea81004fd' ]
    }
    # https://dev.cealect.com/api/customer/select-technician/{servicerequest_id}/
    puts "#{SELECT_TECHNICIAN_FOR_SERVICE_URL}#{service_id}/"
    response = HTTP.auth("Bearer #{@token}").post("#{SELECT_TECHNICIAN_FOR_SERVICE_URL}#{service_id}/", json: data)
    # expect(response.status).to eq(200)
    puts response.inspect
    puts response.body
  end
end

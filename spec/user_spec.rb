require "helper"

describe "User" do
  # before do
  #   @user = { email: "karn@hey.com", password: "0611625983" }
  #   @technician = { email: "t.karn@hotmail.com", password: "0817386508" }
  # end

  describe "Customer" do
    it "Signin" do
      response = signin(USER)
      # puts response.status
      data = ActiveSupport::HashWithIndifferentAccess.new(**JSON.parse(response.body))
      # puts data
      expect(response.code).to eq(200)
      expect(data).to include(:token)
      expect(data).to include(:user)

      user = data[:user]
      expect(user[:display_name]).to eq("K T")
      expect(user[:is_telephone_verified]).to be_truthy
      expect(user[:is_email_verified]).to be_truthy
      expect(user[:telephone]).to eq("0611625983")
    end
  end

  describe "Technician" do
    it "Signin" do
      response = signin(TECHNICIAN)
      # puts response.status
      data = ActiveSupport::HashWithIndifferentAccess.new(**JSON.parse(response.body))
      puts data
      expect(response.code).to eq(200)
      expect(data).to include(:token)
      expect(data).to include(:user)

      user = data[:user]
      expect(user[:display_name]).to eq("กานต์ ถิรสุนทร")
      # expect(user[:is_telephone_verified]).to be_truthy
      # expect(user[:is_email_verified]).to be_truthy
      expect(user[:technician_type]).to be_nil
    end
  end
end

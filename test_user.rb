require "./helper"

describe "User" do
  # before do
  #   @user = { email: "karn@hey.com", password: "0611625983" }
  #   @technician = { email: "t.karn@hotmail.com", password: "0817386508" }
  # end

  describe "Customer" do
    it "Signin" do
      response = HTTP.post(AUTH_URL, json: USER)
      # puts response.status
      data = ActiveSupport::HashWithIndifferentAccess.new(**JSON.parse(response.body))
      puts data
      assert 200, response.code
      assert_includes data, :token
      assert_includes data, :user

      user = data[:user]
      assert_equal "K T", user[:display_name]
      assert_equal true, user[:is_telephone_verified]
      assert_equal true, user[:is_email_verified]
    end
  end

  # describe "Technician" do
  #   assert "a", "a"
  # end
end

require "active_support/core_ext/hash/indifferent_access"
require "http"
require "json"

BASE_URL = "https://dev.cealect.com"
AUTH_URL = "#{BASE_URL}/api/users/api-token-auth/"
CONFIRM_EMAIL_URL = "#{BASE_URL}/api/otp/email-send/"

PROVINCE_URL = "#{BASE_URL}/api/common/province/"
DISTRICT_URL = "#{BASE_URL}/api/common/district/"
SUB_DISTRICT_URL = "#{BASE_URL}/api/common/sub-district/"

MENU_LIST_URL = "#{BASE_URL}/api/service/menu/"
SUB_MENU_LIST_URL = "#{BASE_URL}/api/service/sub-menu/"

TECHNICIAN_LIST = "#{BASE_URL}/api/customer/technician-detail/"

user = { email: "karn@hey.com", password: "0611625983" }
technician = { email: "t.karn@hotmail.com", password: "0817386508" }

# Signin
response = HTTP.post(AUTH_URL, json: user)
body = ActiveSupport::HashWithIndifferentAccess.new(**JSON.parse(response.body))

token = body[:token]

if body[:user][:user_type_display].downcase == "technician"
  puts "Is technician"
else
  puts "Is user"
  unless body[:is_email_verified]
    # puts "validate email"
    # response = HTTP.auth("Bearer #{token}").post(CONFIRM_EMAIL_URL)
    # puts response.inspect
  end
end

# ! Account list
# technician
# t.karn@hotmail.com
# 0817386508

# user
# karn@hey.com
# 0611625983

# * Confirm Email
# POST /

# Menu List#1
# response = HTTP.auth("Bearer #{token}").get(MENU_LIST_URL)
# menu_list = JSON.parse(response.body).collect { |i| ActiveSupport::HashWithIndifferentAccess.new(i) }
# menu_list.each { |l| puts l }
# * Not found icon from response
# body = ActiveSupport::HashWithIndifferentAccess.new(**JSON.parse(response.body))
# pp body

# ! Not Work
# Memu List#2
# response = HTTP.auth("Bearer #{token}").get("#{SUB_MENU_LIST_URL}849ad8dd-9f79-4fc7-8085-fda7f42c1b38/")
# sub_menu_list = ActiveSupport::HashWithIndifferentAccess.new(**JSON.parse(response.body))
# puts sub_menu_list


# Province
# response = HTTP.get(PROVINCE_URL)
# puts response
# puts response.body

# Technician list
response = HTTP.auth("Bearer #{token}").get(TECHNICIAN_LIST)
puts response
puts response.body

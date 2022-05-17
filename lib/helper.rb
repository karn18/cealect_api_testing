# module Helper
#   BASE_URL = "https://dev.cealect.com"
# end

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
SERVICE_MENU_LIST_URL = "#{BASE_URL}/api/service/service/"

TECHNICIAN_LIST_URL = "#{BASE_URL}/api/customer/technician-detail/"

TECHNICIAN_URL = "#{BASE_URL}/api/technician/technician/"
TECHNICIAN_ROLE_LIST = "#{BASE_URL}/api/technician/role-list/"

SERVICE_REQUEST_URL = "#{BASE_URL}/api/customer/service-request/"

# Available users
USER = { email: "karn@hey.com", password: "0611625983" }
TECHNICIAN = { email: "t.karn@hotmail.com", password: "0817386508" }

def signin(user) 
  HTTP.post(AUTH_URL, json: user)
end
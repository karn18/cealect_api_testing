require "helper"

describe "Common" do
  before(:all) do
    response = signin(USER)
    data = ActiveSupport::HashWithIndifferentAccess.new(**JSON.parse(response.body))
    @token = data[:token]
  end

  describe "Province" do
    it "List" do
      response = HTTP.auth("Bearer #{@token}").get(PROVINCE_URL)
      data = JSON.parse(response.body).collect { |i| ActiveSupport::HashWithIndifferentAccess.new(i) }
      expect(data).not_to be_nil
      # puts data
      @first_provice = data[0]
      # puts @first_provice
      expect(@first_provice[:id]).to eq("00000000-0000-0000-0000-000000000001")
      expect(@first_provice[:name_th]).to eq("กรุงเทพมหานคร")
      expect(@first_provice[:name_en]).to eq("Bangkok")
    end
  end
  describe "District" do
    it "List" do
      province_id = "00000000-0000-0000-0000-000000000001"
      response = HTTP.auth("Bearer #{@token}").get("#{DISTRICT_URL}/#{province_id}/")
      data = JSON.parse(response.body).collect { |i| ActiveSupport::HashWithIndifferentAccess.new(i) }
      expect(data).not_to be_nil
      # puts data
      @first_district = data[0]
      # puts @first_district
      expect(@first_district[:id]).to eq("00000000-0000-0000-0000-000000000001")
      expect(@first_district[:name_th]).to eq("พระนคร")
      expect(@first_district[:name_en]).to eq("Khet Phra Nakhon")
    end
  end

  describe "Sub-district" do
    it "List" do
      district_id = "00000000-0000-0000-0000-000000000001"
      response = HTTP.auth("Bearer #{@token}").get("#{SUB_DISTRICT_URL}/#{district_id}/")
      data = JSON.parse(response.body).collect { |i| ActiveSupport::HashWithIndifferentAccess.new(i) }
      expect(data).not_to be_nil
      # puts data
      @first_sub_district = data[0]
      # puts @first_sub_district
      expect(@first_sub_district[:id]).to eq("00000000-0000-0000-0000-000000018705")
      expect(@first_sub_district[:name_th]).to eq("พระบรมมหาราชวัง")
      expect(@first_sub_district[:name_en]).to eq("Phra Borom Maha Ratchawang")
      expect(@first_sub_district[:zip_code]).to eq(10200)
    end
  end
end

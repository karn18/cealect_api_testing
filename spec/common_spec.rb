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
      puts data
      @first_provice = data[0]
      # puts @first_provice
      expect(@first_provice[:id]).to eq("00000000-0000-0000-0000-000000000001")
      expect(@first_provice[:name_th]).to eq("กรุงเทพมหานคร")
      expect(@first_provice[:name_en]).to eq("Bangkok")
    end
  end
  describe "District" do
    it "List" do
      province_id = "00000000-0000-0000-0000-000000000042"
      response = HTTP.auth("Bearer #{@token}").get("#{DISTRICT_URL}/#{province_id}/")
      data = JSON.parse(response.body).collect { |i| ActiveSupport::HashWithIndifferentAccess.new(i) }
      expect(data).not_to be_nil
      puts data
      @first_district = data[2]
      # puts @first_district
      expect(@first_district[:id]).to eq("00000000-0000-0000-0000-000000000370")
      expect(@first_district[:name_th]).to eq("เมืองภูเก็ต")
      expect(@first_district[:name_en]).to eq("Mueang Phuket")
    end
  end

  describe "Sub-district" do
    it "List" do
      district_id = "00000000-0000-0000-0000-000000000370"
      response = HTTP.auth("Bearer #{@token}").get("#{SUB_DISTRICT_URL}/#{district_id}/")
      data = JSON.parse(response.body).collect { |i| ActiveSupport::HashWithIndifferentAccess.new(i) }
      expect(data).not_to be_nil
      puts data
      @first_sub_district = data[1]
      # puts @first_sub_district
      expect(@first_sub_district[:id]).to eq("00000000-0000-0000-0000-0000000caa97")
      expect(@first_sub_district[:name_th]).to eq("เกาะแก้ว")
      expect(@first_sub_district[:name_en]).to eq("Ko Kaeo")
      expect(@first_sub_district[:zip_code]).to eq(83000)
    end
  end
end

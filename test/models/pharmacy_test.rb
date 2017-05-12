require 'test_helper'

class PharmacyTest < ActiveSupport::TestCase
  setup do
    @url = 'http://openapi2.e-gen.or.kr/openapi/service/rest/ErmctInsttInfoInqireService/getParmacyBassInfoInqire'.freeze
  end

  test 'Connect Data go portal' do
    params = { numOfRows: 1 }
    connecting_portal = RestClient.get(@url, { accept: :json, params: params })
    assert_equal connecting_portal.code, 200
  end
end

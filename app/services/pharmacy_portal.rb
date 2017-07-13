class PharmacyPortal
  attr_accessor :options
  include HTTParty
  base_uri 'openapi2.e-gen.or.kr/openapi/service/rest/ErmctInsttInfoInqireService'

  def initialize
    @options = {
        headers: { Accept: 'application/json' },
        query: {
            pageNo: 1,
            numOfRows: 1,
            ServiceKey: ENV['portal_secret_key']
        }
    }
  end

  def infos(numOfRows)
    options[:query][:numOfRows] = numOfRows

    data = JSON.parse self.class.get('/getParmacyBassInfoInqire', options ).body, symbolize_names: true
    data[:response][:body][:items][:item]
  end

  def all_infos
    options[:query][:numOfRows] = 50000

    data = JSON.parse self.class.get('/getParmacyBassInfoInqire', options ).body, symbolize_names: true
    data[:response][:body][:items][:item]
  end
end

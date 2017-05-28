class PharmacyPortal
  attr_reader :options
  include HTTParty
  base_uri 'openapi2.e-gen.or.kr/openapi/service/rest/ErmctInsttInfoInqireService'

  def initialize(numOfRows=1, page=1)
    @options = {
        headers: { Accept: 'application/json' },
        numOfRows: numOfRows,
        page: page,
        ServiceKey: ENV['portal_secret_key']
    }
  end

  def infos
    self.class.get('/getParmacyBassInfoInqire', options )
  end

  def self.all_infos
    options = {
        headers: { Accept: 'application/json' },
        numOfRows: 30,
        ServiceKey: ENV['portal_secret_key']
    }

    data = JSON.parse get('/getParmacyBassInfoInqire', options ).body, symbolize_names: true
    data[:response][:body][:items][:item]
  end
end

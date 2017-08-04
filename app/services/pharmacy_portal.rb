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

  def infos(rows=10)
    self.rows = rows

    data = JSON.parse self.class.get('/getParmacyBassInfoInqire', options ).body, symbolize_names: true
    data[:response][:body][:items][:item]
  end

  def all_infos
    self.rows = 50000

    data = JSON.parse self.class.get('/getParmacyBassInfoInqire', options ).body, symbolize_names: true
    data[:response][:body][:items][:item]
  end

  def total_count
    self.rows = 1

    data = JSON.parse self.class.get('/getParmacyBassInfoInqire', options ).body, symbolize_names: true
    data[:response][:body][:totalCount]
  end
  private

  def rows
    @options[:query][:numOfRows]
  end

  def rows=(rows)
    @options[:query][:numOfRows] = rows
  end

  def page
    @options[:query][:pageNo]
  end

  def page=(page)
    @options[:query][:pageNo] = page
  end
end

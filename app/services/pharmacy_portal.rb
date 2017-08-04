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
    init_page
    self.rows = rows

    data = request_data
    data[:response][:body][:items][:item]
  end

  def all_infos
    self.rows = 50000
    init_page

    data = request_data
    data[:response][:body][:items][:item]
  end

  def total_count
    init_page
    self.rows = 1

    data = request_data
    data[:response][:body][:totalCount]
  end
  def connect_gov
    self.class.get('/getParmacyBassInfoInqire', @options )
  end

  private

  def rows
    @options[:query][:numOfRows]
  end

  def rows=(rows)
    @options[:query][:numOfRows] = rows
  end

  def init_page
    @options[:query][:pageNo] = 1
  end

  def page
    @options[:query][:pageNo]
  end

  def page=(page)
    @options[:query][:pageNo] = page
  end

  def request_data
    JSON.parse connect_gov.body, symbolize_names: true
  end
end

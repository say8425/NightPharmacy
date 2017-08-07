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
    result = Array.new

    getting_progressbar = ProgressBar.create(title: 'Getting the Pharmacy DB',
                                             total: total_loop_count,
                                             format: "%t %b\u{15E7}%i Processed: %p%%",
                                             progress_mark: ' ',
                                             remainder_mark: "\u{FF65}")

    1.upto total_loop_count do |index|
      self.page = index
      self.rows = 5000

      data = request_data
      result.concat data[:response][:body][:items][:item]

      getting_progressbar.increment
    end

    result
  end

  def total_count
    init_page
    self.rows = 1

    data = request_data
    data[:response][:body][:totalCount]
  end

  def create
    if Pharmacy.any?
      abort 'Sorry. Data is already existed.'
    else
      creating_progressbar = ProgressBar.create(title: 'Creating the Pharmacy DB',
                                                total: total_count,
                                                format: "%t %b\u{15E7}%i Processed: %c/%C",
                                                progress_mark: ' ',
                                                remainder_mark: "\u{FF65}",
                                                sleep: 0.05,
                                                throttle_rate: 0.00000001)

      all_infos.each do |info|
        creating_progressbar.increment
      end
    end
  end

  def connect_portal
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
    JSON.parse connect_portal.body, symbolize_names: true
  end

  def total_loop_count
    (total_count / 5000) + 1
  end
end

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

  def items(rows = 10)
    init_page
    self.rows = rows

    data = request_data
    data[:response][:body][:items][:item]
  end

  def all_infos
    result = []
    getting_progressbar = ProgressBar.create(title: 'Preparing',
                                             total: total_loop_count,
                                             format: "%t %b\u{15E7}%i %p%%",
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
      abort '⛔️  Sorry. Data is already existed'
    else
      creating_progressbar = ProgressBar.create(title: 'Creating',
                                                total: total_count,
                                                format: "%t %b\u{15E7}%i %c/%C",
                                                progress_mark: ' ',
                                                remainder_mark: "\u{FF65}")

      all_infos.each do |info|
        begin
          ar_create(info)
        rescue ArgumentError
          creating_progressbar.stop
          puts "❌  #{info[:dutyName]}(#{info[:hpid]}) raise a error "
          p info
          Pharmacy.delete_all
          raise
        else
          creating_progressbar.increment
        end
      end

      puts '✨  Done'
    end
  end

  def connect_portal
    self.class.get('/getParmacyBassInfoInqire', @options)
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

  def ar_create(info)
    Pharmacy.create(
      name:        info[:dutyName],
      info:        info[:dutyInf],
      phone:       info[:dutyTel1],
      address:     info[:dutyAddr],
      way:         info[:dutyMapimg],
      monday:      [info[:dutyTime1s], info[:dutyTime1c]],
      tuesday:     [info[:dutyTime2s], info[:dutyTime2c]],
      wednesday:   [info[:dutyTime3s], info[:dutyTime3c]],
      thursday:    [info[:dutyTime4s], info[:dutyTime4c]],
      friday:      [info[:dutyTime5s], info[:dutyTime5c]],
      saturday:    [info[:dutyTime6s], info[:dutyTime6c]],
      sunday:      [info[:dutyTime7s], info[:dutyTime7c]],
      holiday:     [info[:dutyTime8s], info[:dutyTime8c]],
      hpid:        info[:hpid],
      coordinates: coordinates_for(info)
    )
  end

  def coordinates_for(info)
    if info[:wgs84Lat].nil? && info[:wgs84Lon].nil?
      nil
    else
      "(#{info[:wgs84Lat]}, #{info[:wgs84Lon]})"
    end
  end
end

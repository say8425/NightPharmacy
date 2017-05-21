require 'json'
require 'rest-client'

namespace :portal do
  namespace :db do
    namespace :file do
      desc 'Write all pharmacy data on a file'
      task :write do
        url = 'http://openapi2.e-gen.or.kr/openapi/service/rest/ErmctInsttInfoInqireService/getParmacyBassInfoInqire'.freeze
        key = 'Your Secret key'

        params = { numOfRows: 1 }

        puts 'Getting Data...'
        data = RestClient.get(url, { accept: :json, params: params })
        total_data = (JSON.parse(data.body)['response']['body']['items']['item'])

        puts 'Writing Files...'
        File.write('night-pharmacy.json', total_data.to_json.gsub('\"', ''))

        puts 'Complete!'
      end
    end
  end
end

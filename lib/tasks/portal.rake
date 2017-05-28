require 'json'
require "#{Rails.root}/app/services/pharmacy_portal"

namespace :portal do
  namespace :db do
    namespace :file do
      desc 'Write all pharmacy data on a file'
      task :write do
        puts 'Getting Data...'
        data = PharmacyPortal.all_infos

        puts 'Writing Files...'
        File.write('night-pharmacy.json', data.to_json.gsub('\"', ''))

        puts 'Complete!'
      end
    end
  end
end

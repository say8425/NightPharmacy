require 'json'

namespace :pharmacy do
  namespace :file do
    desc 'Write all pharmacy data on a file'
    task :write  => :environment do
      puts 'Getting Data...'
      pharmacy_data = PharmacyPortal.new

      puts 'Writing Files...'
      File.write('night-pharmacy.json', pharmacy_data.all_infos.to_json.gsub('\"', ''))

      puts 'Complete!'
    end
  end

  namespace :db do
    desc 'Get all pharmacy data and CREATE on table, unless data is existed.'
    task :create => :environment do
      PharmacyPortal.create
    end
  end
end

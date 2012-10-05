namespace :db do
  namespace :test do
    task :prepare => :environment do
      Gonzales.initialize!
    end
  end
end
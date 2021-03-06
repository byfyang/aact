namespace :import do
  namespace :restart do
    task :run, [:force] => :environment do |t, params|
      # Restart full load - load all studies
      ClinicalTrials::Updater.new({:event_type=>'full', :restart=>true}).run
    end
  end
end

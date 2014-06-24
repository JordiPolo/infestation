require_relative '../biohazard'
namespace :mutant do
  desc "Rake task to run Mutant on all the projects"
  task :run => :environment do
    Project.all.each do |project|
      biohazard = Biohazard.new
      puts "Updating #{project.name}"
      biohazard.clone_or_update(project)
      result = biohazard.run_mutant(project)
      if !result.nil? && result > 0
        project.last_result = result
        project.last_run = Time.now
        project.commit = biohazard.current_commit
        project.save!
      end
    end
  end

  desc 'Rake task to continually run Mutant on all the projects'
  task :continuously => :environment do
    #TODO: how to do htis
    while(true) do
      Rake::Task['mutant:run'].invoke
    end
  end
end

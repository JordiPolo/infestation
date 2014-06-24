
class Biohazard
  def self.mutant_directory
    dir = YAML.load_file("#{Rails.root}/config/biohazard.yml")['mutant_directory']
    Dir.mkdir(dir) unless Dir.exists?(dir)
    dir
  end

  def clone_or_update(project)
    @project_dir = project.project_dir

    if Dir.exists?(@project_dir)
      execute_in_project('git pull')
    else
      `cd #{Biohazard.mutant_directory} && git clone #{project.repository}`
    end
    execute_in_project("git checkout #{project.branch}")
    execute_in_project('bundle install')
  end

  def run_mutant(project)
    execute_in_project(project.command)
    result.match(/(\d*)%/)[1].to_i # Get the last number with a % and do not get the %
  end

  def current_commit
    execute_in_project("git log -1 --format=format:%H")
  end

  private

  def execute_in_project(command)
    result = nil
    puts "executing cd #{@project_dir} && #{command}"
    Bundler.with_clean_env { result = `cd #{@project_dir} && #{command}` }
    result
  end
end

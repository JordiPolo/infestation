class Project < ActiveRecord::Base

 MUTANT_DIR = 'mutant'
 MUTANT_REPORT = 'mutant_report.html'
 RESULTS_NOT_READY_TEMPLATE = 'results_not_ready.html'

# validates :repository, presence:true
  validates :repository,
    format: { with: /git@github.com:.*.git/, message: 'Repository must be given in the git@github... format'}

  def name
    repository.match(/\/(.*).git/)[1]
  end

  def result
    if last_result
      "#{last_result}%"
    else
      'Never run'
    end
  end

  def last_commit
    (commit || 'not yet run')[0..10]
  end

  def public_results_file
    if File.exists?(results_file)
      make_results_public
      File.join(public_dir, mutant_report).sub(/.*\/public\//, '')
    else
      RESULTS_NOT_READY_TEMPLATE
    end
  end

  def project_dir
    File.join(Biohazard.mutant_directory, name)
  end

  def results_dir
    File.join(project_dir, MUTANT_DIR)
  end

  def results_file
    File.join(project_dir, mutant_report)
  end

  def mutant_report
    File.join(MUTANT_DIR, MUTANT_REPORT)
  end

  private

  def make_results_public
    unless Dir.exists?(public_dir)
      Dir.mkdir(public_dir)
    end
    FileUtils.cp_r(results_dir, public_dir)
  end

  def public_dir
    "#{Rails.root}/public/#{name}"
  end

end

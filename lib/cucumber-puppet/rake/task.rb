# Defines a Rake task for running cucumber-puppet features.
#
# To create the basic task, call:
#
#   CucumberPuppetRakeTask.new
#
# This defines a task 'cucumber_puppet' that will run features in 'features'
# and 'modules/**/features'.
#
# To further configure the task, you can pass a block:
#
#   CucumberPuppetRakeTask.new do |t|
#     t.cucumber_opts = %w{--format progress}
#   end

class CucumberPuppetRakeTask
  # extra options to pass to cucumber
  attr_accessor :cucumber_opts

  # an Array is preferred, so convert if String
  def cucumber_opts=(opts)
    @cucumber_opts = String === opts ? opts.split(' ') : opts
  end


  # define CucumberPuppet Rake task
  def initialize(task_name = 'cucumber_puppet',
                 desc = 'Run cucumber-puppet features')
    @task_name = task_name
    @desc = desc

    yield self if block_given?

    define_task
  end

  def define_task
    desc @desc
    task @task_name do
      command = []
      command << "cucumber-puppet"
      command << cucumber_opts
      command << "features"
      command << Dir.glob("modules/**/features")
      exit 1 unless system(command.join(' '))
    end
  end
end

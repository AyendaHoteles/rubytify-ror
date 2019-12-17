require "rake"

# NOTE(Jhovan) taken from https://www.eliotsykes.com/test-rails-rake-tasks-with-rspec
#
# Task names should be used in the top-level spac describe
# with prefered 'rake ' prefix for better documentation
#
# describe "rake task_name" do ... end
module TaskExampleGroup
  extend ActiveSupport::Concern

  included do
    # make the Rake task available as 'task' in the spec examples
    subject(:task) { tasks[task_name] }

    let(:task_name) { self.class.top_level_description.sub(/\Arake /, "") }
    let(:tasks) { Rake::Task }
  end
end

RSpec.configure do |config|
  # tag Rake specs with ':task' metadata or put them in the spec/tasks dir
  config.define_derived_metadata(:file_path => %r{/spec/tasks/}) do |meta|
    meta[:type] = :task
  end

  config.include TaskExampleGroup, type: :task

  config.before(:suite) do
    Rails.application.load_tasks
  end
end

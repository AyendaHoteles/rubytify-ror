# frozen_string_literal: true

# Tasks helper.
module Tasks
  extend ActiveSupport::Concern

  included do
    let(:task_name) { self.class.top_level_description.sub(/\Arake /, '') }
    let(:tasks) { Rake::Task }

    # Make the Rake task available as `task` in your examples:
    subject(:task) { tasks[task_name] }
  end
end

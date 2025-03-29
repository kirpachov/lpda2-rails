# frozen_string_literal: true

require "simplecov"

return puts "Skipping coverage" if ENV["SKIP_COVERAGE"] == "true"

SimpleCov.start "rails" do
  enable_coverage :branch

  merge_timeout 3600

  minimum_coverage line: 90, branch: 70
  minimum_coverage_by_file line: 85, branch: 80

  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
  add_group "Interactions", "app/interactions"

  add_filter "/app/interactions/dev"

  # Exclude files with less than 5 lines:
  # Avoid empty files like:
  # module SomeModule
  #   class SomeClass
  #   end
  # end
  add_filter do |source_file|
    uncommented_lines = source_file.lines.reject { |line| line.src.match?(/^\s*#/) }.count
    uncommented_lines < 5
  end
end

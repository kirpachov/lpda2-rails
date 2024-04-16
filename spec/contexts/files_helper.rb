# frozen_string_literal: true

FILES_HELPER = "FILES_HELPER"

RSpec.shared_context FILES_HELPER do
  def spec_file(filename = "joke.txt")
    Rails.root.join("spec", "fixtures", "files", filename)
  end

  def spec_image(filename = "cat.jpeg")
    Rails.root.join("spec", "fixtures", "files", filename)
  end
end

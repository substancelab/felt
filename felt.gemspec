# frozen_string_literal: true

require_relative "lib/felt/version"

Gem::Specification.new do |spec|
  spec.name = "felt"
  spec.version = Felt::VERSION
  spec.authors = ["Jakob Skjerning"]
  spec.email = ["jakob@substancelab.com"]

  spec.summary = "View Components for building forms in Rails applications"
  spec.homepage = "https://github.com/substancelab/felt"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://github.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/substancelab/felt/blob/main/CHANGELOG.md"

  spec.files = Dir["CHANGELOG.md", "LICENSE.txt", "README.md", "lib/**/*"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "i18n"
  spec.add_dependency "view_component"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end

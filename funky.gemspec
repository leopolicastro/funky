# frozen_string_literal: true

require_relative "lib/funky/version"

Gem::Specification.new do |spec|
  spec.name = "funky"
  spec.version = Funky::VERSION
  spec.authors = ["elbpdev"]
  spec.email = ["lbpdev@pm.me"]

  spec.summary = "Interface to consume OpenAI's API."
  spec.description = spec.summary
  spec.homepage = "https://github.com/elbpdev/funky"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "#{spec.homepage}/tree/master"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "ruby-openai"
  spec.add_development_dependency "standard"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end

# frozen_string_literal: true

require_relative "lib/tech_jobs/version"

Gem::Specification.new do |spec|
  spec.name = "tech_jobs"
  spec.version = TechJobs::VERSION
  spec.authors = ["Jim Jones"]
  spec.email = ["jim.jones1@gmail.com"]

  spec.summary = "Streamline finding a tech job."
  spec.description = "Uses Linkedin, Indeed and Apollo to find relevant tech jobs and points of contact."
  spec.homepage = "https://github.com/aantix/tech_jobs"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/aantix/tech_jobs"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "faraday", "~> 2.4"
  spec.add_dependency "lightly", "~> 0.3"
  spec.add_dependency "zip-codes"
  spec.add_development_dependency "pry", "~> 0.13.1"
end

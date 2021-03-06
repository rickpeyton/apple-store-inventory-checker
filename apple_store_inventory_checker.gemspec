lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "apple_store_inventory_checker/version"

Gem::Specification.new do |spec|
  spec.name          = "apple_store_inventory_checker"
  spec.version       = AppleStoreInventoryChecker::VERSION
  spec.authors       = ["Rick Peyton"]
  spec.email         = ["peytorb@gmail.com"]

  spec.summary       = "Check inventory status at the Apple Store"
  spec.description = <<~DESCRIPTION
    Apple has a habit of failing to provide enough supply to meet demand early in a product's lifecycle.

    When a new product comes out I want to check the inventory at my local stores so that I will know when I can walk in and buy it.
  DESCRIPTION
  spec.homepage = "https://github.com/rickpeyton/apple-store-inventory-checker"
  spec.metadata = {
    "changelog_uri" => "https://github.com/rickpeyton/apple-store-inventory-checker/releases",
    "homepage_uri" => "https://github.com/rickpeyton/apple-store-inventory-checker",
    "source_code_uri" => "https://github.com/rickpeyton/apple-store-inventory-checker"
  }
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.4.6"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "debase"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "ramsey_cop"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec_junit_formatter"
  spec.add_development_dependency "ruby-debug-ide"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "solargraph"
  spec.add_development_dependency "webmock"
end

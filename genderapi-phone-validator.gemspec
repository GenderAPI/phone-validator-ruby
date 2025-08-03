# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "genderapi-phone-validator"
  spec.version       = "1.0.2"
  spec.authors       = ["Onur Ozturk"]
  spec.email         = ["support@genderapi.io"]

  spec.summary       = %q{Ruby SDK for validating and formatting international phone numbers using GenderAPI.}
  spec.description   = %q{
    Official Ruby SDK for the Phone Number Validation & Formatter API by GenderAPI.io.

    Features:
    - Validate phone numbers from 240+ countries
    - Format numbers to E.164 or national format
    - Detect number type (mobile, landline, VoIP, etc.)
    - Retrieve region, area code, and country metadata

    Built using HTTParty for robust HTTP requests.
  }

  spec.homepage      = "https://www.genderapi.io"
  spec.metadata = {
    "source_code_uri"     => "https://github.com/GenderAPI/phone-validator-ruby",
    "changelog_uri"       => "https://github.com/GenderAPI/phone-validator-ruby/blob/main/CHANGELOG.md",
    "documentation_uri"   => "https://rubydoc.info/github/GenderAPI/phone-validator-ruby"
  }

  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.6"

  # Runtime dependencies
  spec.add_dependency "httparty", "~> 0.18"
  spec.add_dependency "json", "~> 2.0"

  # Development dependencies
  spec.add_development_dependency "rspec", "~> 3.0"

  # Included files
  spec.files         = Dir["lib/**/*", "LICENSE", "README.md"]
  spec.require_paths = ["lib"]
end

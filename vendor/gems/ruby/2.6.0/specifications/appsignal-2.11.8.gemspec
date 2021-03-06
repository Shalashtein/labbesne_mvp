# -*- encoding: utf-8 -*-
# stub: appsignal 2.11.8 ruby lib ext
# stub: ext/extconf.rb

Gem::Specification.new do |s|
  s.name = "appsignal".freeze
  s.version = "2.11.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/appsignal/appsignal-ruby/issues", "changelog_uri" => "https://github.com/appsignal/appsignal-ruby/blob/main/CHANGELOG.md", "documentation_uri" => "https://docs.appsignal.com/ruby/", "homepage_uri" => "https://docs.appsignal.com/ruby/", "source_code_uri" => "https://github.com/appsignal/appsignal-ruby" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze, "ext".freeze]
  s.authors = ["Robert Beekman".freeze, "Thijs Cadier".freeze, "Tom de Bruijn".freeze]
  s.date = "2021-02-18"
  s.description = "The official appsignal.com gem".freeze
  s.email = ["support@appsignal.com".freeze]
  s.executables = ["appsignal".freeze]
  s.extensions = ["ext/extconf.rb".freeze]
  s.files = ["bin/appsignal".freeze, "ext/extconf.rb".freeze]
  s.homepage = "https://github.com/appsignal/appsignal-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Logs performance and exception data from your app to appsignal.com".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 11"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.8"])
      s.add_development_dependency(%q<timecop>.freeze, [">= 0"])
      s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_development_dependency(%q<yard>.freeze, [">= 0.9.20"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<rubocop>.freeze, ["= 0.50.0"])
    else
      s.add_dependency(%q<rack>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, ["~> 11"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.8"])
      s.add_dependency(%q<timecop>.freeze, [">= 0"])
      s.add_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_dependency(%q<yard>.freeze, [">= 0.9.20"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<rubocop>.freeze, ["= 0.50.0"])
    end
  else
    s.add_dependency(%q<rack>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, ["~> 11"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.8"])
    s.add_dependency(%q<timecop>.freeze, [">= 0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_dependency(%q<yard>.freeze, [">= 0.9.20"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, ["= 0.50.0"])
  end
end

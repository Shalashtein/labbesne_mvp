# -*- encoding: utf-8 -*-
# stub: solidus 2.11.4 ruby lib

Gem::Specification.new do |s|
  s.name = "solidus".freeze
  s.version = "2.11.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.8.23".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Solidus Team".freeze]
  s.date = "2021-01-19"
  s.description = "Solidus is an open source e-commerce framework for Ruby on Rails.".freeze
  s.email = "contact@solidus.io".freeze
  s.homepage = "http://solidus.io".freeze
  s.licenses = ["BSD-3-Clause".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Full-stack e-commerce framework for Ruby on Rails.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<solidus_api>.freeze, ["= 2.11.4"])
      s.add_runtime_dependency(%q<solidus_backend>.freeze, ["= 2.11.4"])
      s.add_runtime_dependency(%q<solidus_core>.freeze, ["= 2.11.4"])
      s.add_runtime_dependency(%q<solidus_frontend>.freeze, ["= 2.11.4"])
      s.add_runtime_dependency(%q<solidus_sample>.freeze, ["= 2.11.4"])
    else
      s.add_dependency(%q<solidus_api>.freeze, ["= 2.11.4"])
      s.add_dependency(%q<solidus_backend>.freeze, ["= 2.11.4"])
      s.add_dependency(%q<solidus_core>.freeze, ["= 2.11.4"])
      s.add_dependency(%q<solidus_frontend>.freeze, ["= 2.11.4"])
      s.add_dependency(%q<solidus_sample>.freeze, ["= 2.11.4"])
    end
  else
    s.add_dependency(%q<solidus_api>.freeze, ["= 2.11.4"])
    s.add_dependency(%q<solidus_backend>.freeze, ["= 2.11.4"])
    s.add_dependency(%q<solidus_core>.freeze, ["= 2.11.4"])
    s.add_dependency(%q<solidus_frontend>.freeze, ["= 2.11.4"])
    s.add_dependency(%q<solidus_sample>.freeze, ["= 2.11.4"])
  end
end

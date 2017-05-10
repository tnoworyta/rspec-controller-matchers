# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: rspec-controller-matchers 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "rspec-controller-matchers".freeze
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Stevo".freeze]
  s.date = "2017-05-10"
  s.description = "Facilitate assertions for common controller responsibilites".freeze
  s.email = "blazejek@gmail.com".freeze
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/rspec-controller-matchers.rb",
    "lib/rspec/matchers/create_record_matcher.rb",
    "lib/rspec/matchers/destroy_record_matcher.rb",
    "lib/rspec/matchers/render_local_matcher.rb",
    "lib/rspec/matchers/update_record_matcher.rb",
    "rspec-controller-matchers.gemspec",
    "spec/fixtures/views/test/index.html.erb",
    "spec/fixtures/views/test/show.html.erb",
    "spec/rspec/matchers/render_local_matcher_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/selleo/rspec-controller-matchers".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.10".freeze
  s.summary = "Facilitate assertions for common controller responsibilites".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>.freeze, [">= 4.2.6"])
      s.add_runtime_dependency(%q<rspec-expectations>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
      s.add_development_dependency(%q<rspec-rails>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rails>.freeze, [">= 4.2.6"])
      s.add_dependency(%q<rspec-expectations>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
      s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>.freeze, [">= 4.2.6"])
    s.add_dependency(%q<rspec-expectations>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
    s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
  end
end


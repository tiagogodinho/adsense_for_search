# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'adsense_for_search/version'

Gem::Specification.new do |s|
  s.name        = 'adsense_for_search'
  s.version     = AdsenseForSearch::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Tiago Rafael Godinho']
  s.email       = ['tiagogodinho3@gmail.com']
  s.homepage    = ''
  s.summary     = %q{AdSense for Search}
  s.description = %q{A simple gem to use "Google AdSense for Search"}
  
  s.add_development_dependency 'rspec'
  s.add_dependency             'rails', '>= 2.3'
  
  s.rubyforge_project = 'adsense_for_search'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split('\n')
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end

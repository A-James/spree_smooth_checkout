# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_smooth_checkout'
  s.version     = '2.1.7'
  s.summary     = 'Smooths out the spree checkout process.'
  s.description = 'This gem includes a redesigned checkout process for Spree that is smooth as silk.'
  s.required_ruby_version = '>= 2.1'

  s.author    = ['Matthew Fenelon', 'Alex James']
  s.email     = ['matthew.fenelon@200creative.com', 'alex.james@200creative.com']
  s.homepage  = 'http://200creative.com'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 2.4.0.rc3'
  s.add_dependency 'spree_frontend', '~> 2.4.0.rc3'
  s.add_dependency 'spree_bootstrap_frontend', '~> 2.1'

  s.add_development_dependency 'sass-rails'
end

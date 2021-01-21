# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'AwsSecretsManagerConfig'
  s.version     = '0.0.0'
  s.date        = '2021-01-19'
  s.summary = 'secrets manager wrapper'
  s.description = 'A secrets manager config gem'
  s.authors     = ['Naoto Fukuda']
  s.files       = ['lib/aws-secrets-manager-config.rb']
  s.license = 'MIT'

  s.required_ruby_version = '~> 2.4'

  s.add_dependency 'aws-sdk-secretsmanager'
  s.add_dependency 'json'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'yard'
end

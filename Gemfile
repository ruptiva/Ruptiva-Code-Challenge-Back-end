# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'active_model_serializers'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'dotenv-rails'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
gem 'simple_token_authentication'
gem 'pundit'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'pry-rails'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

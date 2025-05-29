source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.3' # latest stable Ruby compatible with Rails 7

gem 'rails', '~> 7.1.3' # latest Rails 7.1.x
gem 'sqlite3', '~> 1.6' # compatible with Rails 7
gem 'puma', '~> 6.4'
gem 'sassc-rails', '>= 2.1' # sass-rails is deprecated; use sassc-rails
gem 'webpacker', '~> 5.4' # not actively maintained, consider switching to jsbundling-rails
gem 'turbo-rails', '~> 1.4' # replaces turbolinks in modern Rails
gem 'jbuilder', '~> 2.11'
gem 'bootsnap', '>= 1.17.0', require: false

# UI & Forms
gem 'bulma-rails', '~> 0.9.4'
gem 'simple_form', '~> 5.3.0'

# Authentication & Uploads
gem 'devise', '~> 4.9'
gem 'gravatar_image_tag', '~> 1.2.0'
gem 'carrierwave', '~> 2.2'
gem 'mini_magick', '~> 4.12'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 4.2.0'
  gem 'rack-mini-profiler', '~> 3.1'
  gem 'listen', '~> 3.8'
  gem 'spring', '~> 4.1'
  gem 'better_errors', '~> 2.10'
  gem 'guard', '~> 2.18'
  gem 'guard-livereload', '~> 2.5'
  gem 'binding_of_caller', '~> 1.0'
end

group :test do
  gem 'capybara', '>= 3.40'
  gem 'selenium-webdriver', '>=4.11'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

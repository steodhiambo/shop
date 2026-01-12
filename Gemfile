source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.3'

# Use latest stable Rails version
gem 'rails', '~> 7.1.3'

# Use sqlite3 as the database for Active Record in both development and production
gem 'sqlite3', '~> 1.4'

# Use Puma as the app server
gem 'puma', '~> 6.0'

# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'

# Turbolinks for faster navigation
gem 'turbolinks', '~> 5'

# Build JSON APIs
gem 'jbuilder', '~> 2.7'

# Frontend and styling
gem 'bulma-rails', '~> 0.8.0'
gem 'simple_form', '~> 5.1.0'

# Authentication
gem 'devise', '~> 4.9.4'
gem 'bootsnap', '>= 1.18.6', require: false


# Gravatar, file uploads, and image processing
gem 'gravatar_image_tag', '~> 1.2'
gem 'carrierwave', '~> 2.0'
gem 'mini_magick'
gem 'mimemagic', '~> 0.3.10'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'better_errors', '~> 2.4'
  gem 'guard', '~> 2.14', '>= 2.14.1'
  gem 'guard-livereload', '~> 2.5', '>= 2.5.2'
  gem 'binding_of_caller'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

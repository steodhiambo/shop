#!/bin/bash

# Rails Shop Development Environment Setup Script
# Run this script after installing system dependencies

set -e

echo "🚀 Setting up Rails Shop Development Environment..."

# Check if Ruby is installed
if ! command -v ruby &> /dev/null; then
    echo "❌ Ruby is not installed. Please install Ruby first:"
    echo "   sudo apt install ruby-full ruby-dev build-essential"
    exit 1
fi

echo "✅ Ruby version: $(ruby --version)"

# Check if Bundler is installed
if ! command -v bundle &> /dev/null; then
    echo "📦 Installing Bundler..."
    gem install bundler --user-install
    export PATH="$HOME/.gem/ruby/$(ruby -e 'puts RUBY_VERSION')/bin:$PATH"
fi

echo "✅ Bundler version: $(bundle --version)"

# Install Ruby gems
echo "📦 Installing Ruby gems..."
bundle install

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js:"
    echo "   sudo apt install nodejs npm"
    exit 1
fi

echo "✅ Node.js version: $(node --version)"

# Check if Yarn is installed
if ! command -v yarn &> /dev/null; then
    echo "📦 Installing Yarn..."
    npm install -g yarn
fi

echo "✅ Yarn version: $(yarn --version)"

# Install JavaScript packages
echo "📦 Installing JavaScript packages..."
yarn install

# Setup database
echo "🗄️  Setting up database..."

# Create database if it doesn't exist
if [ ! -f "db/development.sqlite3" ]; then
    echo "Creating database..."
    bundle exec rails db:create
fi

# Run migrations
echo "Running migrations..."
bundle exec rails db:migrate

# Seed database
echo "Seeding database..."
bundle exec rails db:seed

echo ""
echo "🎉 Setup complete!"
echo ""
echo "To start the server, run:"
echo "   rails server"
echo ""
echo "Then visit: http://localhost:3000"
echo ""
echo "📋 Test the new Ad System:"
echo "1. Sign up for an account"
echo "2. Create a product (Sell Product)"
echo "3. Create an ad for that product (Create Ad)"
echo "4. View ads on homepage and /ads"
echo "5. Test editing and deleting your own ads"
echo ""

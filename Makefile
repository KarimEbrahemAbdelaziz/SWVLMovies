bootstrap:
	$(MAKE) install_homebrew
	$(MAKE) install_bundler

	bundle install
	bundle exec pod install

install_homebrew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | ruby

install_bundler:
	gem install bundler
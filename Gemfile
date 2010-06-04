source "http://rubygems.org"

# ruby gems needed for Dragon's Keep
gem 'ezcrypto'
gem 'uuid'
# using datamapper instead of activerecord

#gem 'activerecord', "3.0.0.beta3"
#gem 'sqlite3-ruby'
gem 'dm-core'
gem 'do_sqlite3'
if (RUBY_PLATFORM =~ /linux$/) == nil
  #Decide which gem to load based on version of ruby installed
  if (RUBY_VERSION =~/^1.9/) != nil
    gem 'wxruby-ruby19'
  else
    gem 'wxruby'
  end
else
  gem 'wxruby', "2.0.1"
end

source "http://rubygems.org"

# ruby gems needed for Dragon's Keep
gem 'ezcrypto'
gem 'uuid'
# using datamapper instead of activerecord
# Active record Gems
#gem 'activerecord', "3.0.0.beta3"
#gem 'sqlite3-ruby'
#
# Data Mapper gems 0.10.2
gem 'dm-core', "0.10.2"
gem 'do_sqlite3', '0.10.2'

# Data Mapper gems 1.0.0
#gem 'data_mapper', "1.0.0"
#gem 'dm-sqlite-adapter', "1.0.0"

# Wxruby renames gem for 1.9.1 support
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

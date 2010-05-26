# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'dragons_keep/account'
require 'active_record'
require 'ezcrypto'
require 'uuid'
require 'digest/sha1'

module DragonsKeep
  class AccountControler
    attr_reader :encrypt_pass
    attr_accessor :database

    def encrypt_pass=(pass)
      @encrypt_pass = Digest::SHA1.hexdigest(pass)
    end

    def establish_connection
      migrate = false
      if !(File.exist?(self.database))
        migrate = true
      end
      properties = {
        :adapter => "sqlite3",
        :database => self.database,
      }
      ActiveRecord::Base.establish_connection(properties)     
      path = File.expand_path(File.dirname(__FILE__))
      migrations = File.join(path, "..", "..", "db", "migrations")      
      if migrate
        ActiveRecord::Migrator.migrate(migrations, nil)
      end
      @connection = true
    end

    def initialize(database=nil, password=nil)
      @connection = false
      if(!(database.nil?))
        self.database = database
      end
      if (!(password.nil?))
        self.encrypt_pass = password
      end
    end

    def list()
      if @connection
        Account.find(:all)
      end
    end
    def save_account(account)
      if @connection
        account.save()
      end
    end

    def get(id)

    end
  end
end

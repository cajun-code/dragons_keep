# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'dragons_keep/account'
require 'active_record'
require 'ezcrypto'
require 'uuid'
require 'digest/sha1'

module DragonsKeep
  class AccountController
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
        return Account.find(:all)
      end
      
    end
    def save!(account)
      if @connection
        if account.unencrypted?
          account.encrypt_password(self.encrypt_pass)
        end
        return account.save()
      end      
    end

    def get(id)
      if @connection
        return Account.find id
      end
    end

    def decrypt!(account)
      account.decrpyt_password self.encrypt_pass
    end

    def delete(account)
      account.destroy
    end
  end
end

# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'dragonskeep/account'
require 'activerecord'
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
        :adaptor => "sqlite3",
        :database => self.database,
      }
      ActiveRecord::Base.establish_connection(properties)
      if migrate
        ActiveRecord::Migrator.migrate('../../db/migrations', nil)
      end
      @connection = true
    end

    def initialize
      @connection = false
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
  end
end

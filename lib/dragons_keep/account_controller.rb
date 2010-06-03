# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'dragons_keep/account'
require 'dm-core'
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
     
      DataMapper::Logger.new $stdout, :debug

      DataMapper.setup :default, "sqlite3://#{self.database}"
      if migrate
        DataMapper.auto_migrate!
      else
        validate_connection
      end
      @connection = true
    end
    # Check the first record in the database and decrypt the password to see if the password is valid
    def validate_connection
      account = Account.first
      if ! account.nil?
        self.decrypt!(account)
      end
    end

    def initialize(database=nil, password=nil)
      @connection = false
      if(!(database.nil?))
        self.database = File.expand_path database
      end
      if (!(password.nil?))
        self.encrypt_pass = password
      end
    end

    def list()
      if @connection
        return Account.all
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
        return Account.get id
      end
    end

    def decrypt!(account)
      begin
        account.decrpyt_password self.encrypt_pass
      rescue OpenSSL::Cipher::CipherError
        raise PasswordException, "Password is invalid"
      end
    end

    def delete(account)
      account.destroy
    end
  end
end

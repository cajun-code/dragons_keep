# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'dm-core'
require 'ezcrypto'
module DragonsKeep
  # Account class to store accounts and passwords into a keeper system
  class Account 
    include DataMapper::Resource
    #Data Mapper properties
    property :id, Serial
    property :name, String, :length => 100
    property :password, String, :length => 100
    property :salt, String, :length => 100
    property :user_name, String, :length => 100
    property :url, String, :length => 100

    #register callbacks
    before :save, :before_create
    
    
    # Transient storage of unencrypted password and confirmation field
    attr_accessor :unencrypted_password
    attr_reader :password_confirmation

    # create writer for password confirmation
    def password_confirmation=(value)
      @password_confirmation = value
      @unencrypted = true
    end

    # loading data validate password filed and check status
    def after_initialize   
      @unencrypted = self.password.nil?
    end

    # Before create data set salt and encrypt password
    def before_create
      raise PasswordException, "Password is not Encrypted"  if self.new_password? && self.unencrypted?
    end

    # are we re defining the account password
    def new_password?()
      return !(self.unencrypted_password.blank? and self.password_confirmation.blank?)
    end
    
    # Encrypt the password
    # encrypt_pass = Given password when user created the account information
    def encrypt_password(encrypt_pass)
      if self.unencrypted? && self.unencrypted_password == self.password_confirmation
        self.create_salt
        self.password = Base64.encode64(EzCrypto::Key.encrypt_with_password(encrypt_pass, self.salt, self.unencrypted_password))
        @unencrypted = false
      end
    end
    
    # Decrypt the password 
    # encrypt_pass = Given password when user created the account information
    def decrpyt_password(encrypt_pass)
      if !(self.unencrypted?)
        self.unencrypted_password = EzCrypto::Key.decrypt_with_password(encrypt_pass, self.salt, Base64.decode64( self.password))
        @unencrypted = true
        self.password_confirmation=""
      end
    end
    
    # Is the password encrypted?
    def unencrypted?      
      return (@unencrypted.nil?)? self.password.nil?: @unencrypted
    end
    
    # Generate a random password
    # length_of_password = Length of the password to generate
    # special_char = Can this password need to contain Special Characters
    def generate_password( length_of_pass, special_char )
      chars = []
      ("a".."z").each {|ele| chars << ele}
      ("A".."Z").each {|ele| chars << ele}
      ("0".."9").each {|ele| chars << ele}
      if(special_char)
        ["@", "!", "_",].each {|ele| chars << ele}
      end
      newpass = ""
      1.upto(length_of_pass) { |i| newpass << chars[rand(chars.size-1)] }
      #self.password
      self.unencrypted_password = newpass
      self.password_confirmation = newpass
      @unencrypted = true
    end
    
    # Create the salt
    def create_salt
      self.salt = UUID.generate(:compact)
    end
  end

  # Error on Passwords Encryption or validation
  class PasswordException < RuntimeError    
  end
end

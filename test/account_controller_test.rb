# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')
require 'bundler'
Bundler.setup
require 'test/unit'
require 'dragons_keep/account_controller'
require 'digest/sha1'
module DragonsKeep
  class AccountControllerTest < Test::Unit::TestCase
    def setup()
      @database = File.join(File.dirname(__FILE__), "..", "dragonkeep_test.keep")
      @password = "helloMyNameIs"
      @account_controller = AccountController.new(@database, @password)
      @account_controller.establish_connection
    end

    def test_encrypt_password
      puts "Testing Digest password"
      result = Digest::SHA1.hexdigest(@password)
      puts "Encrypted Password: #{@account_controller.encrypt_pass}"
      assert_equal(result, @account_controller.encrypt_pass)
    end

    def test_new_account
      puts "Testing New Account"
      account = Account.new(:name=>"bitbucket", :url=>"http://www.bitbuckent.org/", :user_name=>"javaalley")
      assert_not_nil(account, "Account was not created")
      account.generate_password(8, true)
      puts "Generated Passowrd #{account.unencrypted_password}"
      assert_not_nil(account.unencrypted_password, "Account password was not generated")
      response = @account_controller.save!(account)
      puts "encrypted Passowrd #{account.password}"
      assert response, "Did not save account"
    end
    
    def test_get_account
      puts "Testing Account Retrival"
      account = @account_controller.get(1)
      assert_not_nil(account, "Account retrival failed")
      puts "Account Name: #{account.name}"
    end
    
    def test_decrypt_account_data
      puts "Testing Decryption "
      account = @account_controller.get(1)
      assert_not_nil(account, "Account retrival failed")
      @account_controller.decrypt!(account)
      assert_not_nil(account.unencrypted_password, "Could not uncrypt password")
      puts "Account Name: #{account.name}"
      puts "Account Password: #{account.unencrypted_password}"
    end


  end
end

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
      @database = File.join(File.dirname(__FILE__), "..", "db", "dragonkeep_test.keep")
      @password = "helloMyNameIs"
      @account_controller = AccountController.new(@database, @password)
    end

    def test_encrypt_password
      puts "Testing Digest password"
      result = Digest::SHA1.hexdigest(@password)
      puts "Encrypted Password: #{@account_controller.encrypt_pass}"
      assert_equal(result, @account_controller.encrypt_pass)
    end

    def test_new_account

    end
    def test_edit_account

    end
    def test_get_account

    end
    def test_encrypt_account_data

    end
    def test_decrypt_account_data

    end


  end
end

# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'dragons_keep/account_controller'

module DragonsKeep
  class AccountControllerTest < Test::Unit::TestCase
    def setup()
      @account_controler
    end

    def test_foo
      #TODO: Write test
      flunk "TODO: Write test"
      # assert_equal("foo", bar)
    end
  end
end

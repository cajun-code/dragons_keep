# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'activerecord'
module DragonsKeep
  class Account < ActiveRecord::Base
    attr_accessor :unencrypted_password, :password_confirmation

    def new_password?()
      return !(self.unencrypted_password.blank? and self.password_confirmation.blank?)
    end
    def encrypt_password(encrypt_pass)
      
    end

    def decrpyt_password(encrypt_pass)

    end


    def generate_password( length_of_pass, special_char )
      chars = ("a".."z").to_a
      chars << ("A".."Z").to_a
      chars << ("0".."9").to_a
      if(special_char)
        chars << ["@", "!", "_",].to_a
      end
      newpass = ""
      1.upto(length_of_pass) { |i| newpass << chars[rand(chars.size-1)] }
      #self.password

    end

  end
end

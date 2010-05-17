# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'activerecord'
module DragonsKeep
  class Account < ActiveRecord::Base


      def generate_password( length_of_pass, special_char )
        chars = ("a".."z").to_a
        chars << ("A".."Z").to_a
        chars << ("0".."9").to_a
        if(special_char)
          chars << ["@", "!", "_",].to_a
        end
        newpass = ""
        1.upto(length_of_pass) { |i| newpass << chars[rand(chars.size-1)] }
        write_attribute(:password , newpass)
      end

    end
end

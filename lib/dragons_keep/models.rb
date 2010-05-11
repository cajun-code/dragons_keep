# To change this template, choose Tools | Templates
# and open the template in the editor.

module DragonsKeep
    class Accounts


      def generate_password( len )
        chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
        newpass = ""
        1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
        return newpass
      end

    end
end

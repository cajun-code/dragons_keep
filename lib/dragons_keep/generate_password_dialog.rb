# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'wx'

module DragonsKeep
  class GeneratePasswordDialog < Wx::Dialog
    def initialize
      main_sizer = Wx::VBoxSizer.new
      grid_sizer = Wx::FlexGridSizer.new(2,2,5,5)
      

      main_sizer.add( self.create_separated_button_sizer(Wx::OK|Wx::CANCEL), 1, Wx::ALIGN_RIGHT)
      set_sizer main_sizer
    end
  end
end

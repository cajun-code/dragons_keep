# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'wx'

module DragonsKeep
  class GeneratePasswordDialog < Wx::Dialog
    ID_SPECIAL = 201
    ID_SIZE = 202
    def initialize(parent, id, title)
      super(parent, id, title)
      self.set_size(Wx::Size.new(400, 100))
      main_sizer = Wx::VBoxSizer.new
      grid_sizer = Wx::FlexGridSizer.new(2,2,5,5)
      grid_sizer.add_growable_col(1)
      # add spacer to grid
      grid_sizer.add(25, 25)
      @use_special_chars = Wx::CheckBox.new self, ID_SPECIAL,:label=> "Use special Characters"
      grid_sizer.add @use_special_chars, 1 , Wx::EXPAND
      @length_password = Wx::SpinCtrl.new self, ID_SIZE, :value=>"8"
      grid_sizer.add Wx::StaticText.new(self, :label=>"Length of Password:"), 0, Wx::ALL |Wx::ALIGN_RIGHT
      grid_sizer.add @length_password, 1, Wx::EXPAND
      main_sizer.add grid_sizer, 1, Wx::EXPAND
      main_sizer.add( self.create_separated_button_sizer(Wx::OK|Wx::CANCEL), 1, Wx::ALIGN_RIGHT)
      set_sizer main_sizer
    end

    def use_special_chars?
      @use_special_chars.value
    end
    def password_length
      @length_password.value
    end
  end
end

# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'wx'

module DragonsKeep
  class AccountDialog < Wx::Dialog
    def initialize parent, id, title
      super parent, id, title
      main_sizer = Wx::BoxSizer(Wx::VERTICAL)
      name_sizer = Wx::BoxSizer(Wx::HORIZONTAL)
      label = Wx::StaticText.new(self, :label=>"Name:", :style=>Wx::ALIGN_RIGHT)
      name_sizer.add label, 0, Wx::ALIGN_CENTER | Wx::ALL, 5
      @name = Wx::TextCtrl.new self, 101
      name_sizer.add @name, 1, Wx::ALIGN_CENTER|Wx::ALL, 5
      main_sizer.add name_sizer, 0, Wx::GROW|Wx::ALIGN_CENTER_VERTICAL|Wx::ALL, 5
      self.set_sizer main_sizer

    end
  end
end

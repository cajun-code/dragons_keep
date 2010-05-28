# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'wx'

module DragonsKeep
  class AccountDialog < Wx::Dialog
    ID_USER_NAME = 103
    ID_ACCOUNT_NAME = 101
    ID_URL = 102
    ID_PASSWORD = 104
    ID_GENERATE_PASSWORD = 105
    ID_SAVE = 106
    ID_COPY_CLIP = 107
    ID_CANCEL = 108

    def initialize parent, id, title
      super parent, id, title
      self.set_size(Wx::Size.new(400, 300))
      main_sizer = Wx::BoxSizer.new(Wx::VERTICAL)
      grid_sizer = Wx::FlexGridSizer.new(4,2,5,5)

      # Create name entry      
      label = Wx::StaticText.new(self, :label=>"Name:")
      grid_sizer.add label, 0,  Wx::ALL |Wx::ALIGN_RIGHT
      @name = Wx::TextCtrl.new self, ID_ACCOUNT_NAME
      grid_sizer.add @name, 1, Wx::EXPAND
      
      # Create url entry      
      label = Wx::StaticText.new(self, :label=>"URL:")
      grid_sizer.add label, 0,Wx::ALL |Wx::ALIGN_RIGHT
      @url = Wx::TextCtrl.new self, ID_URL
      grid_sizer.add @url, 1, Wx::EXPAND
      
      # Create User_name entry      
      label = Wx::StaticText.new(self, :label=>"User Name:")
      grid_sizer.add label, 0, Wx::ALL |Wx::ALIGN_RIGHT
      @user = Wx::TextCtrl.new self, ID_USER_NAME
      grid_sizer.add @user, 1, Wx::EXPAND
      
      # Create password entry      
      label = Wx::StaticText.new(self, :label=>"Password:")
      grid_sizer.add label, 0, Wx::ALL |Wx::ALIGN_RIGHT
      @pass = Wx::TextCtrl.new self, ID_PASSWORD
      grid_sizer.add @pass, 1, Wx::EXPAND
      main_sizer.add grid_sizer, 0, Wx::GROW|Wx::ALIGN_CENTER_VERTICAL|Wx::ALL, 5
      grid_sizer.add_growable_col(1)
      # add spacer to grid
      grid_sizer.add(25, 25)
      # Add generate password button
      @gen_button = Wx::Button.new self, ID_GENERATE_PASSWORD, "Generate Password..."
      grid_sizer.add @gen_button, 1, Wx::EXPAND
      evt_button(ID_GENERATE_PASSWORD){|evt| self.gen_pass_click(evt)} 
      main_sizer.add self.create_separated_button_sizer(Wx::OK|Wx::CANCEL), 1,  Wx::ALIGN_RIGHT
      self.set_sizer main_sizer

    end

    def gen_pass_click(event)
      # display generate pass dialog

      #@account.generate_password
    end

    def account
      save_account!
      @account
    end

    def account=(account)
      @account = account
      load_account
    end

    private
    def save_account
      if not @account.blank?

      end
    end
    def load_account
      if not @account.blank?
        @name.value = @account.name
        @url.value = @account.url
        @user.value = @account.user_name
        @password.value = @account.unencrypted_password.blank? ? @account.password : @account.unencrypted_password
      end
    end

  end
end

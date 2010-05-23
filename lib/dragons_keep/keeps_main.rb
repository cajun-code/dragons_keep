# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'wx'
require 'dragons_keep/account_dialog'

module DragonsKeep
  class KeepsMain < Wx::Frame
    ID_FILE_NEW = 1001
    ID_FILE_CONNECT = 1002
    ID_FILE_NEW_ACCOUNT = 1003
    ID_FILE_EDIT_ACCOUNT = 1004
    ID_EDIT_COPY = 2001



    def initialize(title)
      #create an instance of frame
      super(nil, :title => title, :size => [ 400, 300 ])
      @account_conrtoler = nil
      create_menu_bar
      # Create status bar with one cell
      create_status_bar(1)
      create_contents
      register_events
    end

    # End the application; it should finish automatically when the last
    # window is closed.
    def on_quit
      close()
    end
    def on_new_database
      
    end
    def on_connect_database
      
    end
    def on_new_account
      account_dialog = AccountDialog.new(self, -1, "New Account")
      account_dialog.center_on_screen(Wx::BOTH)
      account_dialog.show_modal()
    end
    def on_edit_account

    end
    def on_copy_password
      Wx::Clipboard.open do | clip |
        clip.data = Wx::TextDataObject.new('Some text')
      end
    end

    private

    def create_menu_bar
      # create menu bar
      menu_bar = Wx::MenuBar.new
      # Create File menu
      menu_file = Wx::Menu.new
      # Create New option on File menu
      menu_file.append ID_FILE_NEW, "&New Database...", "Create New Database"
      # Create Connect option on File menu
      menu_file.append ID_FILE_CONNECT, "&Connect Database...", "Connect to Existing Database"
      # add menu spacer to file menu
      menu_file.append_separator()
      # create new account menu item
      menu_file.append ID_FILE_NEW_ACCOUNT, "New &Account...", "Create a new Account"
      # Create Edit Account menu item
      menu_file.append ID_FILE_EDIT_ACCOUNT, "Edit Account...", "Edit Selected Account"
      
      menu_file.append_separator()
      #Create Exit option on File Menu
      menu_file.append Wx::ID_EXIT, "E&xit\tAlt-X", "Quit this program"
      # add the file to the menu bar
      menu_bar.append menu_file, "&File"
      # Create Edit menu
      menu_edit = Wx::Menu.new
      menu_edit.append ID_EDIT_COPY, "Copy Password", "Copy Password to Clipboard"
      # add edit menu to menu bar
      menu_bar.append menu_edit, "Edit"
      # add Menu Bar to Frame
      self.menu_bar = menu_bar
    end

    def create_contents
      hbox = Wx::HBoxSizer.new
      @account_list = Wx::ListBox.new self, 101, :style=>Wx::LB_SINGLE
      hbox.add(@account_list,1, Wx::EXPAND | Wx::ALL)
      self.set_sizer(hbox)
    end

    def register_events
      evt_menu Wx::ID_EXIT, :on_quit
      evt_menu ID_FILE_NEW, :on_new_database
      evt_menu ID_FILE_CONNECT, :on_connect_database
      evt_menu ID_EDIT_COPY, :on_copy_password
      evt_menu ID_FILE_NEW_ACCOUNT, :on_new_account
      evt_menu ID_FILE_EDIT_ACCOUNT, :on_edit_account
#      evt_update_ui(ID_FILE_NEW_ACCOUNT)do |evt|
#        evt.enable(!@account_conrtoler.nil?)
#      end
      evt_update_ui(ID_FILE_EDIT_ACCOUNT)do |evt|
        evt.enable(!(@account_conrtoler.nil?) && @account_list.get_selections.nil?)
      end
#      evt_update_ui(ID_EDIT_COPY) do |evt|
#        evt.enable(!(@account_conrtoler.nil?) && @account_list.get_selections.nil?)
#      end
    end

  end
end

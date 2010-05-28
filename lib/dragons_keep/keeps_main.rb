# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'wx'
require 'dragons_keep/account_dialog'
require 'dragons_keep/account_controller'

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
      @account_controller = nil
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
      file_dialog = Wx::FileDialog.new(self, "Choose File for new Database", :wildcard=>"Keep Files(*.keep)|*.keep", :style=>Wx::FD_SAVE)
      file_dialog.center_on_screen(Wx::BOTH)
      if file_dialog.show_modal == Wx::ID_OK
        password_dialog = Wx::PasswordEntryDialog.new(self, "Please enter a password for this database")
        if password_dialog.show_modal == Wx::ID_OK
          password = password_dialog.get_value
          file = file_dialog.get_path
          if (file=~/.keep$/) == nil
            file << ".keep"
          end
          #puts file
          @account_controller = AccountController.new file, password
          @account_controller.establish_connection          
          load_list
#          update_ui
        end
      end
    end
    def on_connect_database
      file_dialog = Wx::FileDialog.new(self, "Choose Keep File", :wildcard=>"Keep Files(*.keep)|*.keep")
      file_dialog.center_on_screen(Wx::BOTH)
      if file_dialog.show_modal == Wx::ID_OK
        password_dialog = Wx::PasswordEntryDialog.new(self, "Please enter the password for this database")
        if password_dialog.show_modal == Wx::ID_OK
          password = password_dialog.get_value
          file = file_dialog.get_path
          puts file
          @account_controller = AccountController.new file, password
          @account_controller.establish_connection          
          load_list
#          update_ui
        end
      end
    end
    def on_new_account
      account_dialog = AccountDialog.new(self, -1, "New Account")
      account_dialog.center_on_screen(Wx::BOTH)
      account_dialog.account = Account.new
      if account_dialog.show_modal()== Wx::ID_OK
        @account_controller.save_account(account_dialog.account)
        load_list
      end
    end
    def on_edit_account
      account = @list[@account_list.get_selection]
      account_dialog = AccountDialog.new(self, -1, "Edit Account")
      account_dialog.center_on_screen(Wx::BOTH)
      account_dialog.account = account
      account_dialog.show_modal()
    end
    def on_copy_password
      account = @list[@account_list.get_selection]
      @account_controller.decrypt!(account)
      Wx::Clipboard.open do | clip |
        clip.data = Wx::TextDataObject.new(account.unencrypted_password)
      end
    end
    
    private
    
    def load_list
      @list = @account_controller.list
      @account_list.clear
      @list.each {|ele| @account_list.append(ele.name) }
    end

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
      update_ui
    end

    def update_ui
        evt_update_ui(ID_FILE_NEW_ACCOUNT)do |evt|
        evt.enable(! @account_controller.nil?)
      end
      evt_update_ui(ID_FILE_EDIT_ACCOUNT)do |evt|
        evt.enable(!(@account_controller.nil? && @account_list.is_empty))
      end
      evt_update_ui(ID_EDIT_COPY) do |evt|
        evt.enable(!(@account_controller.nil? && @account_list.is_empty))
      end
    end

  end
end

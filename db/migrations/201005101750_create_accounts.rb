# To change this template, choose Tools | Templates
# and open the template in the editor.

class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.string :password
      t.string :salt
      t.string :url
      t.string :user_name
      
      t.timestamps
    end
  end
  def self.down
    drop_table :accounts
  end
end

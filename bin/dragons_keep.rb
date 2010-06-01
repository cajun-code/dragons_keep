#! /usr/etc ruby
# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'rubygems'
require 'bundler'
Bundler.setup

# Set the path to load from the lib and main directory
path = File.expand_path(File.dirname(__FILE__))
$: << path
$: << File.join(path, "..", "lib")

require 'wx'
require 'dragons_keep/keeps_main'


module DragonsKeep

  class DragonsKeepApp < Wx::App
    def on_init()
      self.app_name = "Dragon's Keep"
      @frame = KeepsMain.new "Dragon's Keep"
      @frame.center_on_screen(Wx::BOTH)
      @frame.show
    end
  end
end

dk = DragonsKeep::DragonsKeepApp.new
dk.main_loop

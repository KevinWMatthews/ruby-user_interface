#!/usr/bin/env ruby

require'minitest'
require 'minitest/autorun'
require_relative '../src/user_interface.rb'

class UserInterfaceTest < MiniTest::Test
  def test_initialize
    UserInterface.new
  end
end

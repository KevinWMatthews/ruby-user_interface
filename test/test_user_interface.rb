#!/usr/bin/env ruby

require'minitest'
require 'minitest/autorun'
require_relative '../src/user_interface.rb'

class UserInterfaceTest < MiniTest::Test
  attr_reader :user_interface, :stdin, :stdout
  def setup
    @stdin = StringIO.new
    @stdout = StringIO.new
    @user_interface = UserInterface.new(stdin: stdin, stdout: stdout)
  end

  def add_items_to_input_stream(item_list)
    item_list.each do |item|
      stdin.puts item
    end
    stdin.rewind
  end

  def test_initialize
    UserInterface.new
  end

  def test_entry
    add_items_to_input_stream(["test"])
    user_input = user_interface.entry("Message")
    assert_equal("test", user_input)
  end
end

#!/usr/bin/env ruby

require'minitest'
require 'minitest/autorun'
require_relative '../src/user_interface.rb'

class UserInterfaceTest < MiniTest::Test
  attr_reader :user_interface, :stdin
  def setup
    @stdin = StringIO.new
    @user_interface = UserInterface.new(stdin: stdin)
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
    user_input = "test"
    add_items_to_input_stream([user_input])
    ui_result = user_interface.entry("Message")
    assert_equal(user_input, ui_result)
  end

  def test_vary_entry
    user_input = "not test"
    add_items_to_input_stream([user_input])
    ui_result = user_interface.entry("Message")
    assert_equal(user_input, ui_result)
  end
end

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

  def read_output_stream
    stdout.rewind
    stdout.read
  end

  def test_initialize
    UserInterface.new
  end

  def test_entry
    user_input = "test"
    prompt = "Message"
    add_items_to_input_stream([user_input])

    ui_result = user_interface.entry(prompt)

    output = read_output_stream

    assert_equal(user_input, ui_result)
    assert (output.include?(prompt))
  end

  def test_vary_entry
    user_input = "not test"
    prompt = "Message"
    add_items_to_input_stream([user_input])

    ui_result = user_interface.entry(prompt)

    output = read_output_stream
    assert_equal(user_input, ui_result)
    assert (output.include?(prompt))
  end
end

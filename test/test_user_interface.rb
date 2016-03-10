#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../src/user_interface.rb'

describe UserInterface, "Test User Interface" do
  let (:stdin) { StringIO.new }
  let (:stdout) { StringIO.new }
  let (:user_interface) { UserInterface.new(stdin: stdin, stdout: stdout) }
  let (:user_input) { "" }
  let (:user_output) { nil }

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

  it "can be initialized" do
    UserInterface.new
  end

  describe "when prompting user for a line of input" do
    it "prints message and returns input" do
      user_input = "test"
      prompt = "Message"
      add_items_to_input_stream([user_input])

      ui_result = user_interface.entry(prompt)

      output = read_output_stream

      assert_equal(user_input, ui_result)
      assert output.include?(prompt), "Unexpected output: #{output}"
    end

    it "can accept varying user input" do
      user_input = "not test"
      prompt = "Message"
      add_items_to_input_stream([user_input])

      ui_result = user_interface.entry(prompt)

      output = read_output_stream
      assert_equal(user_input, ui_result)
      assert output.include?(prompt), "Unexpected output: #{output}"
    end

    it "can display varying messages" do
      user_input = "test"
      prompt = "Different Message"
      add_items_to_input_stream([user_input])

      ui_result = user_interface.entry(prompt)

      output = read_output_stream

      assert_equal(user_input, ui_result)
      assert output.include?(prompt), "Unexpected output: #{output}"
    end
  end
end

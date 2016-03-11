#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../src/user_interface.rb'
include InterfaceFactory

# Expected output should be passed as individual arguments.
# Pass arrays using the splat ('*') operator.
def add_items_to_input_stream(*items)
  items.each do |item|
    stdin.puts item
  end
  stdin.rewind
end

def read_output_stream
  stdout.rewind
  stdout.read
end

# Expected output should be passed as individual arguments.
# Pass arrays using the splat ('*') operator.
def verify_output(*expected_output)
  actual_output = read_output_stream
  expected_output.each do |expected|
    assert actual_output.include?(expected.to_s), show_missing_output(expected, actual_output)
  end
end

def show_missing_output(expected, actual)
  "Expected output not found:\n" +
  "#{expected}\n" +
  "Actual output:\n" +
  "#{actual}\n"
end

describe InterfaceFactory, "Sanity checks for factory" do
  describe "when passed an invalid interface" do
    it "raises an error" do
      assert_raises(RuntimeError) { InterfaceFactory.factory(:not_an_interface) }
    end
  end
end

describe UserInterface, "Test User Interace parent class" do
  let (:user_interface) { UserInterface.new }

  it "can be initialized with default arguments" do
  end

  it "can be initialized with custom IO streams" do
    UserInterface.new(stdin: StringIO.new, stdout: StringIO.new)
  end

  it "#entry" do
    assert_raises(RuntimeError) { user_interface.entry("message") }
  end

  it "#select_from_list" do
    list = [:item1, :item2, :item3]
    assert_raises(RuntimeError) { user_interface.select_from_list("prompt", list) }
  end
end

describe HighLineInterface, "Test HighLine Interface" do
  let (:stdin) { StringIO.new }
  let (:stdout) { StringIO.new }
  let (:user_interface) { InterfaceFactory.factory(:highline, stdin: stdin, stdout: stdout) }
  let (:user_input) { "" }
  let (:user_output) { nil }

  it "can be initialized" do
    InterfaceFactory.factory(:highline)
  end

  describe "when prompting user for a line of input" do
    it "prints message and returns input" do
      user_input = "test"
      prompt = "Message"
      add_items_to_input_stream(user_input)

      ui_result = user_interface.entry(prompt)

      assert_equal(user_input, ui_result)
      verify_output(prompt)
    end

    it "can accept varying user input" do
      user_input = "not test"
      prompt = "Message"
      add_items_to_input_stream(user_input)

      ui_result = user_interface.entry(prompt)

      assert_equal(user_input, ui_result)
      verify_output(prompt)
    end

    it "can display varying messages" do
      user_input = "test"
      prompt = "Different Message"
      add_items_to_input_stream(user_input)

      ui_result = user_interface.entry(prompt)

      assert_equal(user_input, ui_result)
      verify_output(prompt)
    end
  end

  describe "when prompting user to select an item from a list" do
    it "prints all items and returns the user's selection" do
      user_input = 1
      prompt = "Select an item from the list"
      add_items_to_input_stream(user_input)

      list = [:item1, :item2, :item3]
      expected = list[user_input-1]   # HighLine user entries are indexed from 1

      ui_result = user_interface.select_from_list(prompt, list)

      assert_equal(expected, ui_result)
      verify_output(prompt, *list)
    end

    it "sends an error message if the user selects invalid input" do
      user_input = ["invalid", 1]
      prompt = "Select an item from the list"
      add_items_to_input_stream(user_input)

      list = [:item1, :item2, :item3]
      expected = list[1-1]   # HighLine user entries are indexed from 1

      ui_result = user_interface.select_from_list(prompt, list)

      assert_equal(expected, ui_result)
      verify_output(prompt, *list)
    end
  end
end

describe TerminalInterface, "Test basic terminal user interface" do
  let (:stdin) { StringIO.new }
  let (:stdout) { StringIO.new }
  let (:user_interface) { InterfaceFactory.factory(:terminal, stdin: stdin, stdout: stdout) }
  let (:user_input) { "" }
  let (:user_output) { nil }

  it "can be initialized" do
    InterfaceFactory.factory(:terminal)
  end

  describe "when prompting user for a line of input" do
    it "prints message and returns input" do
      user_input = "test"
      prompt = "Message"
      add_items_to_input_stream(user_input)

      ui_result = user_interface.entry(prompt)

      assert_equal(user_input, ui_result)
      verify_output(prompt)
    end

    it "can accept varying user input" do
      user_input = "not test"
      prompt = "Message"
      add_items_to_input_stream(user_input)

      ui_result = user_interface.entry(prompt)

      assert_equal(user_input, ui_result)
      verify_output(prompt)
    end

    it "can display varying messages" do
      user_input = "test"
      prompt = "Different Message"
      add_items_to_input_stream(user_input)

      ui_result = user_interface.entry(prompt)

      assert_equal(user_input, ui_result)
      verify_output(prompt)
    end
  end
end

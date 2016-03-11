#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../src/user_interface.rb'
include InterfaceFactory

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
end

describe HighLineInterface, "Test HighLine Interface" do
  let (:stdin) { StringIO.new }
  let (:stdout) { StringIO.new }
  let (:user_interface) { InterfaceFactory.factory(:highline, stdin: stdin, stdout: stdout) }
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
    InterfaceFactory.factory(:highline)
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

describe TerminalInterface, "Test basic terminal user interface" do
  let (:stdin) { StringIO.new }
  let (:stdout) { StringIO.new }
  let (:user_interface) { InterfaceFactory.factory(:terminal, stdin: stdin, stdout: stdout) }
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
    InterfaceFactory.factory(:terminal)
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

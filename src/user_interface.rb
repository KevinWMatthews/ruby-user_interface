#!/usr/bin/env ruby

require 'highline'

module InterfaceFactory
  class UserInterface
    attr_reader :stdin, :stdout
    def initialize(stdin: $stdin, stdout: $stdout)
      @stdin = stdin
      @stdout = stdout
    end

    def entry(message)
      raise "#{self.class} subclasses must implement: #{__method__}"
    end

    def select_from_list(prompt, list)
      raise "#{self.class} subclasses must implement: #{__method__}"
    end
  end

  class HighLineInterface < UserInterface
    def entry(message)
      ui_system = HighLine.new(stdin, stdout)
      ui_system.ask(message)
    end

    # HOLY SWEET MERCIFUL CRAP the '*' turns an array into an argument list!
    def select_from_list(message, *list)
      ui_system = HighLine.new(stdin, stdout)
      ui_system.choose do |menu|
        menu.prompt = message
        menu.choices(*list)
      end
    end
  end

  class TerminalInterface < UserInterface
    def entry(message)
      stdout.puts message
      stdin.gets.chomp
    end
  end

  def self.factory(interface, stdin: nil, stdout: nil)
    klass_for(interface).new(stdin: stdin, stdout: stdout)
  end

  def self.klass_for(interface)
    interface_class = INTERFACES[interface]
    raise "#{self.name} passed an unknown interface: #{interface}" if interface_class.nil?
    interface_class
  end

  INTERFACES = {
    highline: HighLineInterface,
    terminal: TerminalInterface
  }
end

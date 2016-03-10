#!/usr/bin/env ruby

require 'highline'

class UserInterface
  attr_reader :stdin, :stdout
  def initialize(stdin: $stdin, stdout: $stdout)
    @stdin = stdin
    @stdout = stdout
  end

  def entry(message)
    ui_system = HighLine.new(stdin, stdout)
    ui_system.ask(message)
  end
end

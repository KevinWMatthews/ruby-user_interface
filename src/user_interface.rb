#!/usr/bin/env ruby

class UserInterface
  attr_reader :stdin, :stdout
  def initialize(stdin: $stdin, stdout: $stdout)
    @stdin = stdin
    @stdout = stdout
  end

  def entry(message)
    stdout.puts message
    stdin.gets.chomp
  end
end

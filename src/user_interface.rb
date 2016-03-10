#!/usr/bin/env ruby

class UserInterface
  attr_reader :stdin
  def initialize(stdin: $stdin)
    @stdin = stdin
  end

  def entry(message)
    stdin.gets.chomp
  end
end

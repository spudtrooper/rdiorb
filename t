#!/usr/bin/env ruby

require 'lib/rdio'
include Rdio

def assert_equal(a,b)
  puts "#{a} <=> #{b}"
  if a != b
    puts a
    puts b
  end
end

Rdio::log_json = true
res = Artist.search 'Soundgarden'
res.each do |a|
  puts a.class, a.name
end

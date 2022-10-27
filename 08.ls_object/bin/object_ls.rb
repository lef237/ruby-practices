#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative '../lib/ls_list'

def main
  options, pathname = receive_options
  puts LsList.new(options, pathname).format_files
end

def receive_options
  option_parser = OptionParser.new
  options = {}
  option_parser.on('-a') { |v| options[:all] = v }
  option_parser.on('-r') { |v| options[:reverse] = v }
  option_parser.on('-l') { |v| options[:long] = v }
  option_parser.parse!(ARGV)
  pathname = ARGV[0] || '.'
  [options, pathname]
end

main

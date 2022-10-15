#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative '../lib/files_collection'

def main
  options, pathname = receive_options
  puts FilesCollection.new(options, pathname).output_files
end

def receive_options
  option_parser = OptionParser.new
  options = {}
  option_parser.on('-a') { |v| options[:all] = v }
  option_parser.on('-r') { |v| options[:reverse] = v }
  option_parser.on('-l') { |v| options[:long] = v }
  option_parser.parse!(ARGV)
  pathname = ARGV[0] || '.'
  return options, pathname
end

main

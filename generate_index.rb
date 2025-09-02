#!/usr/bin/env ruby
# frozen_string_literal: true

# generate_index.rb - Standalone script to generate keyword index for Solo Aviation Services Playbook
# This script can be run from the project root to regenerate just the index

puts "📇 Generating keyword index for Solo Aviation Services Playbook..."
puts ""

# Change to the kitabu project directory
Dir.chdir('kitabu') do
  puts "📋 Generating keyword index..."
  system('ruby generate_index.rb')
  
  puts ""
  puts "✅ Index generated successfully!"
  puts "📄 Index file: kitabu/text/[Chapter_Number]_Keyword_Index.md"
  
  puts ""
  puts "🚀 To rebuild the complete playbook with updated index:"
  puts "   ./build_playbook.sh"
end

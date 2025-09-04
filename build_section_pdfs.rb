#!/usr/bin/env ruby
# build_section_pdfs.rb - Build script to generate individual section PDFs

puts "🛩️  Building Individual Section PDFs for Solo Aviation Services Playbook..."
puts ""

# Check if we're in the right directory
unless File.exist?('generate_section_pdfs.rb')
  puts "❌ Error: generate_section_pdfs.rb not found in current directory"
  puts "   Please run this script from the playbook root directory"
  exit 1
end

# Check if kitabu directory exists
unless File.exist?('kitabu')
  puts "❌ Error: kitabu directory not found"
  puts "   Please ensure the kitabu project is set up"
  exit 1
end

# Check if content directory exists
unless File.exist?('content')
  puts "❌ Error: content directory not found"
  puts "   Please ensure the content directory exists"
  exit 1
end

puts "📋 Prerequisites check passed!"
puts ""

# Run the section PDF generator
puts "🚀 Starting section PDF generation..."
puts ""

result = system('ruby generate_section_pdfs.rb')

if result
  puts ""
  puts "✅ All section PDFs generated successfully!"
  puts ""
  puts "📁 Generated files are located in: ./output/"
  puts "📊 Generation report: ./output/generation_report.md"
  puts ""
  puts "🚀 To view all generated PDFs:"
  puts "   open ./output/"
  puts ""
  puts "📖 To view the generation report:"
  puts "   open ./output/generation_report.md"
else
  puts ""
  puts "❌ Section PDF generation failed. Check the output above for errors."
  exit 1
end

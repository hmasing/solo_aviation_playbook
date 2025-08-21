#!/usr/bin/env ruby
# build_playbook.rb - Simple script to build the FBO Operations Playbook PDF

puts "🛩️  Building FBO Operations Playbook..."
puts ""

# Change to the kitabu project directory
Dir.chdir('fbo-operations-playbook') do
  puts "📋 Organizing latest content..."
  system('ruby organize_content.rb')
  
  puts ""
  puts "📖 Generating PDF..."
  result = system('bundle exec kitabu export --only=pdf')
  
  if result
    puts ""
    puts "✅ PDF generated successfully!"
    
    # Copy PDF to root directory for easy access
    if File.exist?('output/fbo-operations-playbook.pdf')
      require 'fileutils'
      FileUtils.cp('output/fbo-operations-playbook.pdf', '../fbo-operations-playbook.pdf')
      puts "📄 PDF copied to root directory: fbo-operations-playbook.pdf"
      puts "📁 Original location: fbo-operations-playbook/output/"
      
      puts ""
      puts "🚀 To open the PDF:"
      puts "   open fbo-operations-playbook.pdf"
      puts "   # Or from original location: open fbo-operations-playbook/output/fbo-operations-playbook.pdf"
    else
      puts "⚠️  PDF not found in expected location"
    end
  else
    puts ""
    puts "❌ PDF generation failed. Check the output above for errors."
  end
end

#!/usr/bin/env ruby
# build_playbook.rb - Simple script to build the Solo Aviation Services Playbook PDF

puts "🛩️  Building Solo Aviation Services Playbook..."
puts ""

# Change to the kitabu project directory
Dir.chdir('solo-aviation-services-playbook') do
  puts "📋 Organizing latest content..."
  system('ruby organize_content.rb')
  
  puts ""
  puts "📖 Generating PDF..."
  result = system('bundle exec kitabu export --only=pdf')
  
  if result
    puts ""
    puts "✅ PDF generated successfully!"
    
    # Copy PDF to root directory for easy access
    if File.exist?('output/solo-aviation-services-playbook.pdf')
      require 'fileutils'
      FileUtils.cp('output/solo-aviation-services-playbook.pdf', '../solo-aviation-services-playbook.pdf')
      puts "📄 PDF copied to root directory: solo-aviation-services-playbook.pdf"
      puts "📁 Original location: solo-aviation-services-playbook/output/"
      
      puts ""
      puts "🚀 To open the PDF:"
      puts "   open solo-aviation-services-playbook.pdf"
      puts "   # Or from original location: open solo-aviation-services-playbook/output/solo-aviation-services-playbook.pdf"
    else
      puts "⚠️  PDF not found in expected location"
    end
  else
    puts ""
    puts "❌ PDF generation failed. Check the output above for errors."
  end
end

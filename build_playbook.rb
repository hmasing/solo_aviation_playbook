#!/usr/bin/env ruby
# build_playbook.rb - Simple script to build the Solo Aviation Services Playbook PDF

puts "🛩️  Building Solo Aviation Services Playbook..."
puts ""

# Change to the kitabu project directory
Dir.chdir('kitabu') do
  puts "📋 Organizing latest content..."
  system('ruby organize_content.rb')
  
  puts ""
  puts "📖 Generating PDF..."
  result = system('bundle exec kitabu export --only=pdf')
  
  if result
    puts ""
    puts "✅ PDF generated successfully!"
    
    # Copy PDF to root output directory for organized structure
    if File.exist?('output/kitabu.pdf')
      require 'fileutils'
      FileUtils.mkdir_p('../output')
      begin
        FileUtils.cp('output/kitabu.pdf', '../output/solo-aviation-services-playbook.pdf')
        puts "📄 Main playbook PDF copied to: output/solo-aviation-services-playbook.pdf"
        puts "📁 Original location: kitabu/output/kitabu.pdf"
      rescue => e
        puts "❌ Failed to copy main playbook PDF: #{e.message}"
        exit 1
      end
    else
      puts "⚠️  Main playbook PDF not found in expected location"
      exit 1
    end
    
    # Return to root directory and generate individual section PDFs
    Dir.chdir('..') do
      puts ""
      puts "🛩️  Generating individual section PDFs..."
      system('ruby build_section_pdfs.rb')
      
      puts ""
      puts "🚀 To open the main playbook:"
      puts "   open output/solo-aviation-services-playbook.pdf"
      puts ""
      puts "🚀 To view all generated PDFs:"
      puts "   open output/"
    end
  else
    puts ""
    puts "❌ PDF generation failed. Check the output above for errors."
  end
end

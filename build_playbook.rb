#!/usr/bin/env ruby
# build_playbook.rb - Simple script to build the Solo Aviation Services Playbook PDF

require 'yaml'
require 'fileutils'

puts "🛩️  Building Solo Aviation Services Playbook..."
puts ""

# Load central configuration
config_path = File.join(__dir__, 'config', 'playbook.yml')
unless File.exist?(config_path)
  puts "❌ Error: Central configuration file not found at #{config_path}"
  exit 1
end

central_config = YAML.load_file(config_path)
puts "📋 Loaded central configuration:"
puts "   Version: #{central_config['version']}"
puts "   Revision Date: #{central_config['revision_date']}"
puts "   Published At: #{central_config['published_at']}"
puts ""

# Update kitabu.yml with central config values
kitabu_config_path = File.join(__dir__, 'kitabu', 'config', 'kitabu.yml')
if File.exist?(kitabu_config_path)
  kitabu_config = YAML.load_file(kitabu_config_path)
  
  # Update version-related fields
  kitabu_config['version'] = central_config['version']
  kitabu_config['revision_date'] = central_config['revision_date']
  kitabu_config['published_at'] = central_config['published_at']
  kitabu_config['title'] = central_config['title']
  kitabu_config['publisher'] = central_config['publisher']
  kitabu_config['copyright'] = central_config['copyright']
  kitabu_config['uid'] = central_config['uid']
  kitabu_config['identifier'] = central_config['identifier']
  kitabu_config['authors'] = central_config['authors']
  kitabu_config['subject'] = central_config['subject']
  kitabu_config['keywords'] = central_config['keywords']
  kitabu_config['language'] = central_config['language']
  
  # Write updated kitabu.yml
  File.write(kitabu_config_path, kitabu_config.to_yaml)
  puts "✅ Updated kitabu.yml with central configuration values"
else
  puts "❌ Error: kitabu.yml not found at #{kitabu_config_path}"
  exit 1
end

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

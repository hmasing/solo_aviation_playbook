#!/usr/bin/env ruby
# organize_content.rb - Script to organize FBO playbook content for Kitabu

require 'fileutils'
require 'yaml'

# Paths
SOURCE_DIR = '../'
TEXT_DIR = './text'
IMAGES_DIR = './images'
ASSETS_DIR = '../assets'

# Clear existing sample content
FileUtils.rm_rf(Dir.glob("#{TEXT_DIR}/*.md*"))

puts "📋 Organizing FBO Operations Playbook content for Kitabu..."

# Create the main content files in proper order
content_structure = [
  {
    file: '01_Introduction.md',
    title: '# Introduction',
    content: File.read("#{SOURCE_DIR}/README.md")
  },
  {
    file: '02_FBO_Services.md',
    title: '# FBO Services',
    content: File.read("#{SOURCE_DIR}/content/01-fbo-services/README.md")
  },
  {
    file: '03_Maintenance_Operations.md',
    title: '# Maintenance Operations', 
    content: File.read("#{SOURCE_DIR}/content/02-maintenance-operations/README.md")
  },
  {
    file: '04_Flight_School_Operations.md',
    title: '# Flight School Operations',
    content: File.read("#{SOURCE_DIR}/content/03-flight-school-operations/README.md")
  },
  {
    file: '05_Safety_Compliance.md',
    title: '# Safety and Compliance',
    content: File.read("#{SOURCE_DIR}/content/04-safety-compliance/README.md")
  },
  {
    file: '06_Marketing_Customer_Retention.md',
    title: '# Marketing and Customer Retention',
    content: File.read("#{SOURCE_DIR}/content/05-marketing-customer-retention/README.md")
  },
  {
    file: '07_Administrative_Financial.md',
    title: '# Administrative and Financial',
    content: File.read("#{SOURCE_DIR}/content/06-administrative-financial/README.md")
  },
  {
    file: '08_Content_Guidelines.md',
    title: '# Content Guidelines',
    content: File.read("#{SOURCE_DIR}/.cursor/rules/aviation-content-guidelines.mdc")
  },
  {
    file: '09_Template_Reference.md',
    title: '# Template Reference',
    content: File.read("#{SOURCE_DIR}/templates/standard-procedure-template.md")
  }
]

# Process each section
content_structure.each_with_index do |section, index|
  puts "  📄 Creating #{section[:file]}..."
  
  # Clean up content - remove navigation links and adjust headers
  content = section[:content]
  
  # Remove navigation links (lines starting with [← or [Next)
  content = content.gsub(/^\[←.*?\]\(.*?\).*?$/, '')
  content = content.gsub(/^\[Next.*?\]\(.*?\).*?$/, '')
  
  # Remove YAML frontmatter if present
  content = content.gsub(/^---\n.*?^---\n/m, '')
  
  # Fix relative links to be absolute or remove broken ones
  content = content.gsub(/\]\(\.\.\//, '](../')
  content = content.gsub(/\]\(\.\.\/\.\.\//, '](../../')
  
  # Clean up extra whitespace
  content = content.strip
  
  # Write the file
  File.write("#{TEXT_DIR}/#{section[:file]}", content)
end

# Copy assets if they exist
if Dir.exist?(ASSETS_DIR)
  puts "  📁 Copying assets..."
  
  # Copy images
  if Dir.exist?("#{ASSETS_DIR}/images")
    FileUtils.cp_r("#{ASSETS_DIR}/images/.", IMAGES_DIR)
  end
  
  # Note: Forms and references will be referenced in the text but not directly copied
  # as Kitabu focuses on the main document content
end

puts "✅ Content organization complete!"
puts ""
puts "📖 To generate the PDF:"
puts "   cd fbo-operations-playbook"
puts "   bundle exec kitabu export pdf"
puts ""
puts "📱 To generate other formats:"
puts "   bundle exec kitabu export html"
puts "   bundle exec kitabu export epub"
puts ""
puts "🎨 To customize styling, edit:"
puts "   templates/styles/pdf.css"
puts "   templates/styles/html.css"

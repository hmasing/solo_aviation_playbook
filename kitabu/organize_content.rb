#!/usr/bin/env ruby
# frozen_string_literal: true

# organize_content.rb - Script to organize FBO playbook content for Kitabu

require 'fileutils'
require 'yaml'
require 'pathname'

class OrganizeContent
  # Paths
  SOURCE_DIR = Pathname.new('../content')
  TEXT_DIR = Pathname.new('./text')
  IMAGES_DIR = Pathname.new('./images')
  ASSETS_DIR = Pathname.new('../assets')

  def initialize
    @content_sections = discover_content_sections
  end

  def organize!
    clear_existing_content
    puts '📋 Organizing Solo Aviation Services Playbook content for Kitabu...'

    create_content_files
    copy_assets

    puts '✅ Content organization complete!'
    print_usage_instructions
  end

  private

  def discover_content_sections
    return [] unless SOURCE_DIR.exist?

    Dir.glob(SOURCE_DIR.join('*')).sort.filter_map do |dir_path|
      next unless File.directory?(dir_path)

      dir_name = File.basename(dir_path)
      
      # Check if directory has any non-README.md files
      procedure_files = Dir.glob(File.join(dir_path, '*.md'))
                           .reject { |f| File.basename(f) == 'README.md' }
      
      next if procedure_files.empty?

      # Extract section number and name from directory
      if dir_name.match(/^(\d+)-(.+)$/)
        section_num = ::Regexp.last_match(1).to_i
        section_name = ::Regexp.last_match(2).split('-').map(&:capitalize).join(' ')

        {
          source_dir: dir_path,
          section_number: section_num,
          section_name: section_name,
          output_file: format('%02d_%s.md', section_num + 1, section_name.gsub(' ', '_')),
          readme_path: nil  # No longer using README files
        }
      end
    end.compact
  end

  def clear_existing_content
    FileUtils.rm_rf(Dir.glob("#{TEXT_DIR}/*.md*"))
  end

  def create_content_files
    @content_sections.each do |section|
      create_section_file(section)
    end
  end

  def create_section_file(section)
    puts "  📄 Creating #{section[:output_file]}..."

    content = read_and_process_content(section)

    if content.empty?
      puts "    WARNING: Skipping empty content for #{section[:output_file]}"
    else
      output_path = TEXT_DIR.join(section[:output_file])
      File.write(output_path, content)
      puts "    SUCCESS: Created #{section[:output_file]} (#{content.length} chars)"
    end
  end

  def read_and_process_content(section)
    # Since we're excluding README files, start with a section header
    content = "# #{section[:section_name]}\n\n"
    
    # Add all procedure files directly
    expand_procedure_stubs(section, content)
  end

  def clean_content_for_pdf(content)
    # Remove YAML frontmatter if present
    content = content.gsub(/^---\n.*?^---\n/m, '')

    # Remove navigation links
    content = content.gsub(/^\[←.*?\]\(.*?\).*?$/, '')
    content = content.gsub(/^\[Next.*?\]\(.*?\).*?$/, '')

    # Fix relative links to be absolute or remove broken ones
    content = content.gsub(%r{\]\(\.\./}, '](../')
    content = content.gsub(%r{\]\(\.\./\.\./}, '](../../')

    # Clean up extra whitespace and multiple blank lines
    content.gsub(/\n{3,}/, "\n\n").strip
  end

  def expand_procedure_stubs(section, content)
    # Look for individual procedure files in the section directory
    procedure_files = Dir.glob(File.join(section[:source_dir], '*.md'))
                         .reject { |f| File.basename(f) == 'README.md' }
                         .sort

    if procedure_files.any?
      puts "    Found #{procedure_files.length} procedure files to include"

      procedure_content = procedure_files.map do |proc_file|
        proc_content = File.read(proc_file)
        clean_content_for_pdf(proc_content)
      end.join("\n\n---\n\n")

      # Append procedure content after the main section content
      content += "\n\n#{procedure_content}" unless procedure_content.strip.empty?
    end

    content
  end

  def copy_assets
    return unless ASSETS_DIR.exist?

    puts '  📁 Copying assets...'

    # Copy images
    images_source = ASSETS_DIR.join('images')
    return unless images_source.exist?

    FileUtils.cp_r("#{images_source}/.", IMAGES_DIR)
    puts "    SUCCESS: Copied images from #{images_source}"
  end

  def print_usage_instructions
    puts ''
    puts '📖 To generate the PDF:'
    puts '   cd kitabu'
    puts '   bundle exec kitabu export pdf'
    puts ''
    puts '📱 To generate other formats:'
    puts '   bundle exec kitabu export html'
    puts '   bundle exec kitabu export epub'
    puts ''
    puts '🎨 To customize styling, edit:'
    puts '   templates/styles/pdf.css'
    puts '   templates/styles/html.css'
    puts ''
    puts '📝 To add procedures:'
    puts '   Create .md files in content/[section]/ directories'
    puts '   Re-run this script to include them in the playbook'
  end
end

# Run the organization if this file is executed directly
if __FILE__ == $PROGRAM_NAME
  organizer = OrganizeContent.new
  organizer.organize!
end

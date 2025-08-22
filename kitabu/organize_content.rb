#!/usr/bin/env ruby
# frozen_string_literal: true

# organize_content.rb - Script to organize FBO playbook content for Kitabu

require 'fileutils'
require 'yaml'
require 'pathname'
require 'active_support/core_ext/string/inflections'

class OrganizeContent
  # Paths
  SOURCE_DIR = Pathname.new('../content')
  TEXT_DIR = Pathname.new('./text')
  IMAGES_DIR = Pathname.new('./images')
  ASSETS_DIR = Pathname.new('../assets')
  CHAPTER_CONFIG = Pathname.new('../config/chapter_order.yml')

  def initialize
    setup_aviation_inflections
    @content_sections = load_configured_sections
  end

  def organize!
    clear_existing_content
    puts '📋 Organizing Solo Aviation Services Playbook content for Kitabu...'

    create_content_files
    generate_keyword_index
    copy_assets

    puts '✅ Content organization complete!'
    print_usage_instructions
  end

  private

  def setup_aviation_inflections
    # Configure ActiveSupport inflections for aviation acronyms
    ActiveSupport::Inflector.inflections do |inflect|
      # Aviation acronyms that should remain uppercase
      inflect.acronym 'FBO'      # Fixed Base Operator
      inflect.acronym 'GSE'      # Ground Support Equipment
      inflect.acronym 'TSA'      # Transportation Security Administration
      inflect.acronym 'FAA'      # Federal Aviation Administration
      inflect.acronym 'OSHA'     # Occupational Safety and Health Administration
      inflect.acronym 'SMS'      # Safety Management System
      inflect.acronym 'STC'      # Supplemental Type Certificate
      inflect.acronym 'AOG'      # Aircraft on Ground
      inflect.acronym 'CRM'      # Customer Relationship Management
      inflect.acronym 'IFR'      # Instrument Flight Rules
      inflect.acronym 'VFR'      # Visual Flight Rules
      inflect.acronym 'CFI'      # Certified Flight Instructor
      inflect.acronym 'ATP'      # Airline Transport Pilot
      inflect.acronym 'MEL'      # Minimum Equipment List
      inflect.acronym 'AD'       # Airworthiness Directive
      inflect.acronym 'SB'       # Service Bulletin
      inflect.acronym 'TBO'      # Time Between Overhauls
      inflect.acronym 'NTSB'     # National Transportation Safety Board
      inflect.acronym 'ICAO'     # International Civil Aviation Organization
      inflect.acronym 'ATC'      # Air Traffic Control
      inflect.acronym 'AWOS'     # Automated Weather Observing System
      inflect.acronym 'ASOS'     # Automated Surface Observing System
      inflect.acronym 'NOTAM'    # Notice to Airmen
      inflect.acronym 'METAR'    # Meteorological Aerodrome Report
      inflect.acronym 'TAF'      # Terminal Aerodrome Forecast
      inflect.acronym 'GPS'      # Global Positioning System
      inflect.acronym 'VOR'      # VHF Omnidirectional Range
      inflect.acronym 'ILS'      # Instrument Landing System
      inflect.acronym 'DME'      # Distance Measuring Equipment
      inflect.acronym 'ADF'      # Automatic Direction Finder
      inflect.acronym 'TCAS'     # Traffic Collision Avoidance System
      inflect.acronym 'GPWS'     # Ground Proximity Warning System
      inflect.acronym 'TAWS'     # Terrain Awareness and Warning System
      inflect.acronym 'EFB'      # Electronic Flight Bag
      inflect.acronym 'WAAS'     # Wide Area Augmentation System
      inflect.acronym 'RNAV'     # Area Navigation
      inflect.acronym 'RNP'      # Required Navigation Performance
      inflect.acronym 'PBN'      # Performance Based Navigation
      inflect.acronym 'RVSM'     # Reduced Vertical Separation Minimum
    end
  end

  def load_configured_sections
    unless CHAPTER_CONFIG.exist?
      puts "❌ Chapter configuration file not found: #{CHAPTER_CONFIG}"
      puts "   Creating default configuration..."
      create_default_chapter_config
      return []
    end

    config = YAML.load_file(CHAPTER_CONFIG)
    chapters = config['chapters'] || []
    
    puts "📖 Loading #{chapters.length} chapters from configuration..."

    chapters.each_with_index.filter_map do |chapter_config, index|
      # Skip disabled chapters
      next if chapter_config['enabled'] == false

      dir_name = chapter_config['directory']
      dir_path = SOURCE_DIR.join(dir_name)

      # Check if directory exists
      unless dir_path.exist? && dir_path.directory?
        puts "   ⚠️  WARNING: Directory not found: #{dir_name} (skipping)"
        next
      end

      # Check if directory has a README.md file
      readme_path = dir_path.join('README.md')
      unless readme_path.exist?
        puts "   ⚠️  WARNING: No README.md found in #{dir_name} (skipping)"
        next
      end

      # Get procedure files (non-README.md files)
      procedure_files = Dir.glob(dir_path.join('*.md'))
                           .reject { |f| File.basename(f) == 'README.md' }

      # Determine section name (use configured title or derive from directory)
      section_name = chapter_config['title'] || derive_section_name_from_directory(dir_name)
      
      # Use index + 1 as section number to maintain order
      section_num = index + 1

      puts "   ✓ Loaded: #{section_name} (#{procedure_files.length} procedures)"

      {
        source_dir: dir_path.to_s,
        section_number: section_num,
        section_name: section_name,
        output_file: format('%02d_%s.md', section_num, section_name.gsub(' ', '_')),
        readme_path: readme_path.to_s,
        procedure_files: procedure_files
      }
    end.compact
  end

  def derive_section_name_from_directory(dir_name)
    # Extract section name from directory, handling numbered prefixes
    if dir_name.match(/^(\d+)-(.+)$/)
      raw_name = ::Regexp.last_match(2)
    else
      raw_name = dir_name
    end
    
    format_section_name(raw_name)
  end

  def create_default_chapter_config
    # Auto-discover existing directories to create a default config
    discovered_sections = discover_content_sections_legacy
    
    config = {
      'chapters' => discovered_sections.map do |section|
        {
          'directory' => File.basename(section[:source_dir]),
          'title' => section[:section_name],
          'enabled' => true,
          'description' => "Auto-generated entry for #{section[:section_name]}"
        }
      end
    }

    File.write(CHAPTER_CONFIG, config.to_yaml)
    puts "   ✓ Created default configuration at #{CHAPTER_CONFIG}"
    puts "   📝 Edit this file to customize chapter order and titles"
  end

  def discover_content_sections_legacy
    # Legacy method for auto-discovery (used only for creating default config)
    return [] unless SOURCE_DIR.exist?

    Dir.glob(SOURCE_DIR.join('*')).sort.filter_map do |dir_path|
      next unless File.directory?(dir_path)

      dir_name = File.basename(dir_path)
      
      # Check if directory has a README.md file
      readme_path = File.join(dir_path, 'README.md')
      next unless File.exist?(readme_path)

      # Get procedure files (non-README.md files)
      procedure_files = Dir.glob(File.join(dir_path, '*.md'))
                           .reject { |f| File.basename(f) == 'README.md' }

      # Extract section number and name from directory
      if dir_name.match(/^(\d+)-(.+)$/)
        section_num = ::Regexp.last_match(1).to_i
        section_name = format_section_name(::Regexp.last_match(2))

        {
          source_dir: dir_path,
          section_number: section_num,
          section_name: section_name,
          output_file: format('%02d_%s.md', section_num, section_name.gsub(' ', '_')),
          readme_path: readme_path,
          procedure_files: procedure_files
        }
      end
    end.compact
  end

  def format_section_name(raw_name)
    # Convert hyphen-separated words to title case using Rails inflections
    # This will properly handle acronyms like 'fbo' -> 'FBO'
    raw_name.split('-').map do |word|
      # Use titleize to get proper title casing with acronym support
      word.titleize
    end.join(' ')
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
    # Start with README content as the chapter introduction
    content = ""
    
    # Add anchor for page references
    chapter_anchor = "<a id=\"chapter-#{section[:section_number]}-start\"></a>\n\n"
    
    if section[:readme_path] && File.exist?(section[:readme_path])
      readme_content = File.read(section[:readme_path])
      cleaned_readme = clean_content_for_pdf(readme_content)
      # Convert README H2+ headers to H3+ so they don't appear in TOC
      content = chapter_anchor + convert_readme_headers(cleaned_readme)
    else
      # Fallback to simple header if no README
      content = "#{chapter_anchor}# #{section[:section_name]}\n\n"
    end
    
    # Add all procedure files as subsections
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

  def convert_readme_headers(content)
    # Convert README H2+ headers to H3+ so they don't appear in TOC
    # Keep H1 as-is (chapter title), but push everything else down
    content.gsub(/^(#+) (.+)$/) do |match|
      level = $1.length
      title = $2
      if level == 1
        match # Keep H1 unchanged
      elsif level <= 5
        "#{'#' * (level + 1)} #{title}" # H2->H3, H3->H4, etc.
      else
        match # Leave H6 unchanged
      end
    end
  end

  def convert_h1_to_h2(content)
    # Convert all headers down one level so only the main procedure title appears in TOC
    # H1 -> H2 (procedure title becomes subsection under chapter)
    # H2 -> H3 (major sections become sub-subsections)  
    # H3 -> H4 (process steps become deeper subsections)
    # etc.
    content.gsub(/^(#+) (.+)$/) do |match|
      level = $1.length
      title = $2
      # Only convert up to H5 to avoid going too deep
      if level <= 5
        "#{'#' * (level + 1)} #{title}"
      else
        match # Leave H6 unchanged
      end
    end
  end

  def expand_procedure_stubs(section, content)
    # Use the procedure files from the section data
    procedure_files = section[:procedure_files] || []

    if procedure_files.any?
      puts "    Found #{procedure_files.length} procedure files to include"

      procedure_content = procedure_files.sort.map do |proc_file|
        proc_content = File.read(proc_file)
        cleaned_content = clean_content_for_pdf(proc_content)
        
        # Convert H1 headers in procedures to H2 to make them subsections
        cleaned_content = convert_h1_to_h2(cleaned_content)
        
        cleaned_content
      end.join("\n\n---\n\n")

      # Append procedure content after the main section content
      content += "\n\n#{procedure_content}" unless procedure_content.strip.empty?
    else
      puts "    No procedure files found - using README content only"
    end

    content
  end

  def generate_keyword_index
    puts '  📇 Generating keyword index...'
    
    # Load and run the index generator
    require_relative 'generate_index'
    generator = IndexGenerator.new
    generator.generate!
  rescue => e
    puts "    WARNING: Index generation failed: #{e.message}"
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
    puts '📝 To customize chapter order and titles:'
    puts '   Edit ../config/chapter_order.yml'
    puts '   Reorder chapters, set custom titles, or disable chapters'
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

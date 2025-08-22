#!/usr/bin/env ruby
# frozen_string_literal: true

# generate_index.rb - Generate comprehensive keyword index for Solo Aviation Services Playbook
# This script scans all content files and creates a detailed index with page references

require 'pathname'
require 'yaml'

class IndexGenerator
  # Paths
  TEXT_DIR = Pathname.new('./text')
  OUTPUT_DIR = Pathname.new('./text')

  # Aviation-specific terms to always include in index
  AVIATION_TERMS = %w[
    aircraft airplane helicopter
    pilot CFI instructor
    fuel 100LL JetA avgas
    runway taxiway ramp hangar
    ATC tower ground control
    IFR VFR weather METAR TAF
    maintenance inspection annual
    FBO line service
    FAA regulation CFR
    safety emergency
    client passenger crew
    navigation GPS VOR
    radio frequency communication
    preflight postflight
    logbook documentation
    insurance liability
    training certification
    avionics transponder
    engine propeller
    landing takeoff approach
    clearance NOTAM
    weather minimums visibility
    fuel quality contamination
    marshalling parking
    security TSA
    billing invoice payment
    scheduling dispatch
    emergency evacuation
    compliance audit
    parts inventory
    tools equipment calibration
    hazmat disposal
    OSHA environmental
  ].freeze

  # Operational terms from FBO context
  OPERATIONAL_TERMS = %w[
    client team member leader
    procedure process workflow
    quality control inspection
    billing invoice payment
    scheduling coordination
    communication protocol
    safety training certification
    equipment maintenance
    inventory management
    documentation records
    compliance regulations
    emergency response
    client experience service
    performance metrics
    continuous improvement
  ].freeze

  # Common regulatory references
  REGULATORY_TERMS = [
    '14 CFR', 'Part 61', 'Part 91', 'Part 121', 'Part 135', 'Part 139', 'Part 141', 'Part 145',
    'FAA', 'NTSB', 'TSA', 'OSHA', 'EPA',
    'AIM', 'Advisory Circular', 'AC',
    'ICAO', 'ASTM', 'NFPA'
  ].freeze

  def initialize
    @index_entries = {}
    @all_terms = (AVIATION_TERMS + OPERATIONAL_TERMS + REGULATORY_TERMS).uniq.sort
  end

  def generate!
    puts '📋 Generating comprehensive keyword index for Solo Aviation Services Playbook...'

    scan_content_files
    extract_additional_terms
    create_index_file

    puts '✅ Keyword index generation complete!'
    puts "📄 Index saved to: #{OUTPUT_DIR}/09_Keyword_Index.md"
  end

  private

  def scan_content_files
    return unless TEXT_DIR.exist?

    text_files = Dir.glob(TEXT_DIR.join('*.md')).sort
    puts "  🔍 Scanning #{text_files.length} content files..."

          text_files.each do |file_path|
        next if File.basename(file_path).start_with?('09_') # Skip existing index files

        scan_file(file_path)
      end
  end

  def scan_file(file_path)
    content = File.read(file_path)
    file_name = File.basename(file_path, '.md')
    chapter_name = extract_chapter_name(file_name)

    puts "    📖 Scanning #{chapter_name}..."

    # Scan for all terms (case-insensitive)
    @all_terms.each do |term|
      # Create regex pattern for whole word matching
      pattern = /\b#{Regexp.escape(term)}\b/i

      matches = content.scan(pattern)
      next unless matches.any?

      # Normalize term for indexing
      normalized_term = normalize_term(term)

      @index_entries[normalized_term] ||= []
      @index_entries[normalized_term] << {
        chapter: chapter_name,
        file: file_name,
        occurrences: matches.length
      }
    end

    # Extract additional terms from headers and bold text
    extract_terms_from_headers(content, chapter_name, file_name)
    extract_terms_from_bold_text(content, chapter_name, file_name)
  end

  def extract_chapter_name(file_name)
    # Convert file names like "01_Fbo_Services" to "FBO Services"
    parts = file_name.split('_')
    return file_name unless parts.length >= 2

    chapter_num = parts[0]
    chapter_name = parts[1..].join(' ')

    # Clean up common abbreviations
    chapter_name = chapter_name.gsub(/Fbo/, 'FBO')
                               .gsub(/Crm/, 'CRM')
                               .gsub(/Sms/, 'SMS')

    "Chapter #{chapter_num.to_i}: #{chapter_name}"
  end

  def normalize_term(term)
    # Normalize terms for consistent indexing
    term.downcase.strip
  end

  def extract_terms_from_headers(content, chapter_name, file_name)
    # Extract terms from markdown headers (## Header Text)
    headers = content.scan(/^#+\s+(.+)$/i)
    headers.flatten.each do |header|
      # Extract meaningful terms from headers (skip common words)
      words = header.split(/\s+/).reject { |w| common_word?(w) }
      words.each do |word|
        cleaned_word = word.gsub(/[^\w\s-]/, '').strip.downcase
        next if cleaned_word.length < 3

        @index_entries[cleaned_word] ||= []
        @index_entries[cleaned_word] << {
          chapter: chapter_name,
          file: file_name,
          occurrences: 1,
          context: 'header'
        }
      end
    end
  end

  def extract_terms_from_bold_text(content, chapter_name, file_name)
    # Extract terms from bold text (**term**)
    bold_terms = content.scan(/\*\*([^*]+)\*\*/i)
    bold_terms.flatten.each do |term|
      cleaned_term = term.gsub(/[^\w\s-]/, '').strip.downcase
      next if cleaned_term.length < 3 || common_word?(cleaned_term)

      @index_entries[cleaned_term] ||= []
      @index_entries[cleaned_term] << {
        chapter: chapter_name,
        file: file_name,
        occurrences: 1,
        context: 'emphasis'
      }
    end
  end

  def common_word?(word)
    # Skip common English words that don't add value to index
    common_words = %w[
      the and or but for with from this that these those
      will shall should could would may might can must
      have has had been being are was were will be
      process procedure step steps phase phases
      section chapter part parts
      complete completed completion
      ensure verify check confirm
      perform conduct execute
      maintain monitor review
      coordinate communicate
      document record file
      system systems
      information data
      required necessary needed
      appropriate proper correct
      following below above
      during before after
      include including includes
      provide provides provided
      establish established
      implement implemented
      develop developed
      create created
      manage managed
      support supported
    ].freeze

    common_words.include?(word.downcase.strip)
  end

  def extract_additional_terms
    # Add any frequently occurring terms that weren't in our predefined lists
    puts '  🔍 Extracting additional significant terms...'

    # This could be enhanced to automatically detect frequently occurring terms
    # For now, we'll rely on the predefined lists
  end

  def create_index_file
    puts '  📝 Creating index file...'

    index_content = generate_index_markdown

    output_path = OUTPUT_DIR.join('09_Keyword_Index.md')
    File.write(output_path, index_content)

    puts "    ✅ Index file created with #{@index_entries.keys.length} indexed terms"
  end

  def generate_index_markdown
    # Sort entries alphabetically and filter for more focused index
    sorted_entries = @index_entries.sort_by { |term, _| term }
    
    # Filter to only include more significant terms (reduce verbosity)
    filtered_entries = sorted_entries.select do |term, references|
      # Include if:
      # 1. Term is in our predefined important lists
      # 2. Term appears in multiple chapters
      # 3. Term has high occurrence count
      is_important_term = @all_terms.include?(term) || 
                         references.length > 1 || 
                         references.sum { |ref| ref[:occurrences] } >= 3
      
      # Skip very common words that got through
      !overly_common_word?(term) && is_important_term
    end

    content = <<~MARKDOWN
      # Index

      <div class="keyword-index">

    MARKDOWN

    current_letter = ''

    filtered_entries.each do |term, references|
      # Group by first letter
      first_letter = term[0].upcase
      if first_letter != current_letter
        current_letter = first_letter
        content += "\n<div class=\"index-section\">\n\n## #{current_letter}\n\n"
      end

      # Capitalize term for display
      display_term = format_term_for_display(term)
      
      # Create page reference anchors for PDF
      page_refs = generate_page_references(references)

      # Traditional index format with dotted leaders
      content += "<div class=\"index-entry\">\n"
      content += "<span class=\"index-term\">#{display_term}</span>\n"
      content += "<span class=\"index-leaders\"></span>\n"
      content += "<span class=\"index-pages\">#{page_refs}</span>\n"
      content += "</div>\n\n"
    end

          # Skip the regulatory cross-reference for a more compact traditional index
      # content += generate_regulatory_cross_reference
    content += "\n</div>\n"

    content
  end

  def format_term_for_display(term)
    # Handle special formatting for different types of terms
    if term.match?(/^\d+\s*cfr/)
      # Format regulatory references
      term.split.map { |word| word.match?(/cfr/i) ? word.upcase : word }.join(' ')
    elsif term.length <= 4 && term.upcase == term
      # Keep acronyms in uppercase
      term.upcase
    else
      # Regular term formatting
      term.split.map(&:capitalize).join(' ')
    end
  end

  def generate_page_references(references)
    # Group by chapter and create page reference links
    chapter_refs = references.group_by { |ref| ref[:chapter] }
    
    ref_parts = chapter_refs.keys.sort.map do |chapter|
      # Extract chapter number for page reference
      chapter_num = chapter.match(/Chapter (\d+)/)[1] if chapter.match(/Chapter (\d+)/)
      
      if chapter_num
        # Create anchor link that PrinceXML can resolve to actual page numbers
        "<a href=\"#chapter-#{chapter_num}-start\">#{chapter_num}</a>"
      else
        chapter.split(':').last.strip
      end
    end
    
    ref_parts.join(', ')
  end

  def overly_common_word?(term)
    # Additional filter for overly common words that add no value
    overly_common = %w[
      chapter chapters section sections
      procedure procedures process processes
      operations operation operational
      management manage managed
      services service
      requirements requirement required
      standards standard
      information info
      systems system
      general specific
      appropriate proper
      necessary needed
      following
      including
      provided
      established
      implemented
      developed
      created
      maintained
      supported
      reviewed
      approved
      completed
      performed
      conducted
      coordinated
      documented
      recorded
      monitored
      verified
      confirmed
      ensured
    ].freeze
    
    overly_common.include?(term.downcase.strip)
  end

  def generate_regulatory_cross_reference
    <<~MARKDOWN

      ---

      ## Regulatory Cross-Reference

      ### Federal Aviation Regulations (14 CFR)
      - **Part 1**: Definitions and Abbreviations
      - **Part 21**: Certification Procedures for Products and Articles#{'  '}
      - **Part 23**: Airworthiness Standards: Normal Category Airplanes
      - **Part 43**: Maintenance, Preventive Maintenance, Rebuilding, and Alteration
      - **Part 61**: Certification: Pilots, Flight Instructors, and Ground Instructors
      - **Part 65**: Certification: Airmen Other Than Flight Crewmembers
      - **Part 91**: General Operating and Flight Rules
      - **Part 121**: Operating Requirements: Domestic, Flag, and Supplemental Operations
      - **Part 135**: Operating Requirements: Commuter and On Demand Operations
      - **Part 139**: Certification of Airports
      - **Part 141**: Pilot Schools
      - **Part 145**: Repair Stations

      ### Other Regulatory Sources
      - **AIM**: Aeronautical Information Manual
      - **Advisory Circulars (AC)**: FAA guidance documents
      - **OSHA Standards (29 CFR)**: Workplace safety regulations
      - **EPA Regulations (40 CFR)**: Environmental protection standards
      - **NTSB Regulations (49 CFR Part 830)**: Accident reporting requirements
      - **TSA Regulations (49 CFR Parts 1540-1562)**: Transportation security requirements

    MARKDOWN
  end

  def generate_aviation_acronyms_section
    <<~MARKDOWN

      ## Common Aviation Acronyms

      **A&P**: Airframe and Powerplant Mechanic#{'  '}
      **AC**: Advisory Circular#{'  '}
      **AIM**: Aeronautical Information Manual#{'  '}
      **ATC**: Air Traffic Control#{'  '}
      **ATIS**: Automatic Terminal Information Service#{'  '}
      **CFI**: Certified Flight Instructor#{'  '}
      **CFR**: Code of Federal Regulations#{'  '}
      **CTAF**: Common Traffic Advisory Frequency#{'  '}
      **ELT**: Emergency Locator Transmitter#{'  '}
      **FAA**: Federal Aviation Administration#{'  '}
      **FBO**: Fixed Base Operator#{'  '}
      **GPS**: Global Positioning System#{'  '}
      **ICAO**: International Civil Aviation Organization#{'  '}
      **IFR**: Instrument Flight Rules#{'  '}
      **ILS**: Instrument Landing System#{'  '}
      **METAR**: Meteorological Aerodrome Report#{'  '}
      **NOTAM**: Notice to Airmen#{'  '}
      **NTSB**: National Transportation Safety Board#{'  '}
      **OSHA**: Occupational Safety and Health Administration#{'  '}
      **PIC**: Pilot in Command#{'  '}
      **STC**: Supplemental Type Certificate#{'  '}
      **TAF**: Terminal Aerodrome Forecast#{'  '}
      **TSA**: Transportation Security Administration#{'  '}
      **VFR**: Visual Flight Rules#{'  '}
      **VOR**: VHF Omnidirectional Range

    MARKDOWN
  end
end

# Run the generator if called directly
if __FILE__ == $PROGRAM_NAME
  generator = IndexGenerator.new
  generator.generate!
end

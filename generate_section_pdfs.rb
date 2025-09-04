#!/usr/bin/env ruby
# frozen_string_literal: true

# generate_section_pdfs.rb - Script to generate individual PDFs for each section within each chapter
# This script creates separate PDF files for each procedure/section in the playbook

require 'fileutils'
require 'yaml'
require 'pathname'
require 'tmpdir'
require 'active_support/core_ext/string/inflections'

class SectionPDFGenerator
  # Paths
  SOURCE_DIR = Pathname.new('./content')
  KITABU_DIR = Pathname.new('./kitabu')
  OUTPUT_DIR = Pathname.new('./section-pdfs')
  CHAPTER_CONFIG = Pathname.new('./config/chapter_order.yml')

  def initialize
    setup_aviation_inflections
    @content_sections = load_configured_sections
    @generated_pdfs = []
  end

  def generate_all_section_pdfs!
    puts "🛩️  Generating individual section PDFs for Solo Aviation Services Playbook..."
    puts ""

    # Create output directory
    FileUtils.mkdir_p(OUTPUT_DIR)
    
    # Clear existing section PDFs
    clear_existing_section_pdfs

    @content_sections.each do |section|
      generate_section_pdfs(section)
    end

    generate_summary_report
    puts ""
    puts "✅ Section PDF generation complete!"
    puts "📁 Generated #{@generated_pdfs.length} individual PDFs in: #{OUTPUT_DIR}"
    puts ""
    puts "🚀 To view all generated PDFs:"
    puts "   open #{OUTPUT_DIR}"
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
      return []
    end

    config = YAML.load_file(CHAPTER_CONFIG)
    chapters = config['chapters'] || []

    puts "📖 Loading #{chapters.length} chapters from configuration..."

    chapters.filter_map.with_index do |chapter_config, index|
      # Skip disabled chapters
      next if chapter_config['enabled'] == false

      dir_name = chapter_config['directory']
      dir_path = SOURCE_DIR.join(dir_name)

      # Check if directory exists
      unless dir_path.exist? && dir_path.directory?
        puts "   ⚠️  WARNING: Directory not found: #{dir_name} (skipping)"
        next
      end

      # Get procedure files (exclude README.md and overview files)
      procedure_files = Dir.glob(dir_path.join('*.md'))
                           .reject { |f| ['README.md', '00-chapter-overview.md'].include?(File.basename(f)) }

      # Determine section name (use configured title or derive from directory)
      section_name = chapter_config['title'] || derive_section_name_from_directory(dir_name)

      # Extract chapter number from directory name or use index
      chapter_number = if dir_name.match(/^(\d+)-/)
                         ::Regexp.last_match(1)
                       else
                         sprintf("%02d", index + 1)
                       end

      puts "   ✓ Loaded: #{section_name} (#{procedure_files.length} procedures)"

      {
        source_dir: dir_path.to_s,
        section_name: section_name,
        chapter_number: chapter_number,
        procedure_files: procedure_files,
        include_overview: chapter_config.fetch('include_overview', true)
      }
    end.compact
  end

  def derive_section_name_from_directory(dir_name)
    # Extract section name from directory, handling numbered prefixes
    raw_name = if dir_name.match(/^(\d+)-(.+)$/)
                 ::Regexp.last_match(2)
               else
                 dir_name
               end

    format_section_name(raw_name)
  end

  def format_section_name(raw_name)
    # Convert hyphen-separated words to title case using Rails inflections
    raw_name.split('-').map(&:titleize).join(' ')
  end

  def clear_existing_section_pdfs
    puts "🧹 Clearing existing section PDFs..."
    # Remove all PDF files in the root directory
    FileUtils.rm_rf(Dir.glob("#{OUTPUT_DIR}/*.pdf"))
    # Remove all chapter directories and their contents
    FileUtils.rm_rf(Dir.glob("#{OUTPUT_DIR}/*/"))
  end

  def generate_section_pdfs(section)
    puts "  📄 Generating PDFs for: #{section[:section_name]}"
    
    # Generate PDF for chapter overview if it exists and should be included
    if section[:include_overview]
      overview_path = File.join(section[:source_dir], '00-chapter-overview.md')
      if File.exist?(overview_path)
        generate_single_section_pdf(section, overview_path, 'Chapter Overview')
      end
    end

    # Generate PDFs for each procedure
    section[:procedure_files].each do |proc_file|
      generate_single_section_pdf(section, proc_file)
    end
  end

  def generate_single_section_pdf(section, file_path, custom_title = nil)
    file_name = File.basename(file_path, '.md')
    
    # Extract section number from filename (e.g., "01-procedure-name" -> "01")
    section_number = file_name.split('-').first
    
    # Get chapter number for filename
    chapter_number = section[:chapter_number] || "00"
    
    # Create chapter directory name
    chapter_dir_name = "#{chapter_number}_#{sanitize_filename(section[:section_name])}"
    
    # Determine the title for this section
    if custom_title
      section_title = custom_title
      output_filename = "#{chapter_number}_#{sanitize_filename(section[:section_name])}_#{section_number}_#{sanitize_filename(custom_title)}.pdf"
    else
      # Extract title from the markdown file
      content = File.read(file_path)
      title_match = content.match(/^#\s+(.+)$/)
      section_title = title_match ? title_match[1].strip : file_name.gsub(/^\d+-/, '').gsub('-', ' ').titleize
      output_filename = "#{chapter_number}_#{sanitize_filename(section[:section_name])}_#{section_number}_#{sanitize_filename(section_title)}.pdf"
    end

    puts "    📖 Creating: #{chapter_dir_name}/#{output_filename}"

    # Create temporary kitabu project for this section
    temp_kitabu_dir = create_temp_kitabu_project(section, file_path, section_title)
    
    begin
      # Generate PDF using kitabu
      result = generate_pdf_with_kitabu(temp_kitabu_dir, output_filename, chapter_dir_name)
      
      if result
        pdf_info = {
          filename: output_filename,
          chapter_dir: chapter_dir_name,
          section: section[:section_name],
          title: section_title
        }
        
        # Add file size if the file exists
        full_path = OUTPUT_DIR.join(chapter_dir_name, output_filename)
        if File.exist?(full_path)
          pdf_info[:size] = File.size(full_path)
        end
        
        @generated_pdfs << pdf_info
        puts "      ✅ Generated: #{chapter_dir_name}/#{output_filename}"
      else
        puts "      ❌ Failed to generate: #{chapter_dir_name}/#{output_filename}"
      end
    ensure
      # Clean up temporary directory
      FileUtils.rm_rf(temp_kitabu_dir)
    end
  end

  def create_temp_kitabu_project(section, file_path, section_title)
    # Create temporary directory
    temp_dir = Dir.mktmpdir("kitabu_section_")
    
    # Copy kitabu structure
    FileUtils.cp_r("#{KITABU_DIR}/.", temp_dir)
    
    # Create content for this section
    content = prepare_section_content(section, file_path, section_title)
    
    # Write the content to the text directory
    text_dir = File.join(temp_dir, 'text')
    FileUtils.mkdir_p(text_dir)
    
    # Clear existing content and add our section
    FileUtils.rm_rf(Dir.glob("#{text_dir}/*.md"))
    File.write(File.join(text_dir, '01_section.md'), content)
    
    # Extract section number from filename
    file_name = File.basename(file_path, '.md')
    section_number = file_name.split('-').first
    
    # Create a custom HTML file that bypasses the template system
    create_custom_html_file(temp_dir, section_title, content, section, section_number)
    
    # Update kitabu config for this section
    update_kitabu_config(temp_dir, section_title)
    
    temp_dir
  end

  def prepare_section_content(section, file_path, section_title)
    content = File.read(file_path)
    
    # Clean content for PDF
    cleaned_content = clean_content_for_pdf(content)
    
    # Add section header
    section_header = "# #{section_title}\n\n"
    section_header += "*From: #{section[:section_name]}*\n\n"
    section_header += "---\n\n"
    
    section_header + cleaned_content
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

  def create_custom_html_file(temp_dir, section_title, content, section_info = nil, section_number = nil)
    # Extract just the content we need - skip frontmatter, keep title and content
    lines = content.split("\n")
    
    # Find where frontmatter ends
    frontmatter_end = -1
    lines.each_with_index do |line, i|
      if line.strip == '---' && i > 0
        frontmatter_end = i
        break
      end
    end
    
    # Get content after frontmatter
    content_lines = frontmatter_end >= 0 ? lines[(frontmatter_end + 1)..-1] : lines
    content_lines = content_lines.reject { |line| line.strip.empty? }
    
    # Convert to simple HTML with proper list handling
    html_content = []
    in_list = false
    list_type = nil
    
    content_lines.each do |line|
      line = line.strip
      next if line.empty?
      
      if line.start_with?('# ')
        # Add chapter info above the title and include section number in title
        chapter_info = "<div class='chapter-info'>Chapter #{section_info[:chapter_number]}: #{section_info[:section_name]}</div>"
        section_title_with_number = "#{section_number}. #{line[2..-1]}"
        html_content << chapter_info
        html_content << "<div class='section-title'>#{section_title_with_number}</div>"
        in_list = false
      elsif line.start_with?('## ')
        html_content << "</ul>" if in_list
        html_content << "<h2>#{line[3..-1]}</h2>"
        in_list = false
      elsif line.start_with?('### ')
        html_content << "</ul>" if in_list
        html_content << "<h3>#{line[4..-1]}</h3>"
        in_list = false
      elsif line.start_with?('#### ')
        html_content << "</ul>" if in_list
        html_content << "<h4>#{line[5..-1]}</h4>"
        in_list = false
      elsif line.start_with?('- ')
        if !in_list
          html_content << "<ul>"
          in_list = true
          list_type = 'ul'
        end
        # Process bold text within list items
        list_content = line[2..-1]
        list_content = list_content.gsub(/\*\*(.+?)\*\*/, '<strong>\1</strong>')
        html_content << "<li>#{list_content}</li>"
      elsif line.match(/^\d+\. /)
        if !in_list || list_type != 'ol'
          html_content << "</ul>" if in_list
          html_content << "<ol>"
          in_list = true
          list_type = 'ol'
        end
        # Process bold text within list items
        list_content = line.sub(/^\d+\. /, '')
        list_content = list_content.gsub(/\*\*(.+?)\*\*/, '<strong>\1</strong>')
        html_content << "<li>#{list_content}</li>"
      else
        html_content << "</ul>" if in_list
        in_list = false
        
        # Process bold text in paragraphs
        paragraph_content = line
        paragraph_content = paragraph_content.gsub(/\*\*(.+?)\*\*/, '<strong>\1</strong>')
        paragraph_content = paragraph_content.gsub(/\*(.+?)\*/, '<em>\1</em>')
        html_content << "<p>#{paragraph_content}</p>"
      end
    end
    
    # Close any open list
    html_content << "</ul>" if in_list
    
    html_content = html_content.join("\n")
    
    # Get chapter and section info for headers/footers
    chapter_name = section_info ? section_info[:section_name] : "Unknown Chapter"
    chapter_number = section_info ? section_info[:chapter_number] : "00"
    
    # Create clean HTML file that uses external CSS
    html_file = <<~HTML
      <!DOCTYPE html>
      <html>
      <head>
        <title>#{section_title}</title>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="../templates/styles/section_pdf.css">
        <style>
          .chapter-info {
            font-size: 16px;
            color: #008df5;
            margin-bottom: 8px;
            font-weight: bold;
          }
          .section-title { 
            font-size: 24px; 
            font-weight: bold; 
            color: #333; 
            border-bottom: 2px solid #008df5; 
            padding-bottom: 10px; 
            margin-bottom: 20px;
            page-break-after: avoid;
          }
          h2 { color: #555; margin-top: 20px; }
          h3 { color: #666; margin-top: 15px; }
          p { margin: 10px 0; line-height: 1.4; }
          ul, ol { 
            margin: 10px 0; 
            padding-left: 20px; 
          }
          li { 
            margin: 5px 0; 
            line-height: 1.4;
          }
          strong { font-weight: bold; }
          em { font-style: italic; }
        </style>
      </head>
      <body>
        <div class="chapter" data-chapter="#{chapter_number}" data-section="#{section_number}">
          <div class="hidden-chapter-title" style="string-set: chapter-title content(text);">#{chapter_name}</div>
          <div class="hidden-section-title" style="string-set: section-title content(text);">#{section_title}</div>
          <div class="hidden-section-number" style="string-set: section-number content(text);">#{section_number}</div>
          <div class="hidden-section-name" style="string-set: section-name content(text);">#{section_title.gsub(/^\d+\.\s*/, '')}</div>
          #{html_content}
        </div>
      </body>
      </html>
    HTML
    
    # Write the HTML file
    File.write(File.join(temp_dir, 'text', '01_section.html'), html_file)
  end

  def convert_markdown_to_html(content)
    # Simple markdown to HTML conversion for basic formatting
    html = content
    
    # Remove YAML frontmatter if present
    html = html.gsub(/^---\n.*?\n---\n/m, '')
    
    # Keep the main title, just remove frontmatter
    
    # Convert headers
    html = html.gsub(/^# (.+)$/, '<h1>\1</h1>')
    html = html.gsub(/^## (.+)$/, '<h2>\1</h2>')
    html = html.gsub(/^### (.+)$/, '<h3>\1</h3>')
    html = html.gsub(/^#### (.+)$/, '<h4>\1</h4>')
    html = html.gsub(/^##### (.+)$/, '<h5>\1</h5>')
    html = html.gsub(/^###### (.+)$/, '<h6>\1</h6>')
    
    # Convert bold and italic
    html = html.gsub(/\*\*(.+?)\*\*/, '<strong>\1</strong>')
    html = html.gsub(/\*(.+?)\*/, '<em>\1</em>')
    
    # Convert code blocks
    html = html.gsub(/```(.+?)```/m, '<pre><code>\1</code></pre>')
    html = html.gsub(/`(.+?)`/, '<code>\1</code>')
    
    # Convert lists
    html = html.gsub(/^(\s*)- (.+)$/, '\1<li>\2</li>')
    html = html.gsub(/^(\s*)\d+\. (.+)$/, '\1<li>\2</li>')
    
    # Convert paragraphs - simpler approach
    lines = html.split("\n")
    result = []
    current_paragraph = []
    
    lines.each do |line|
      line = line.strip
      if line.empty?
        if current_paragraph.any?
          result << "<p>#{current_paragraph.join(' ')}</p>"
          current_paragraph = []
        end
      elsif line.start_with?('<h') || line.start_with?('<pre') || line.start_with?('<ul') || line.start_with?('<ol') || line.start_with?('<li>')
        if current_paragraph.any?
          result << "<p>#{current_paragraph.join(' ')}</p>"
          current_paragraph = []
        end
        result << line
      else
        current_paragraph << line
      end
    end
    
    if current_paragraph.any?
      result << "<p>#{current_paragraph.join(' ')}</p>"
    end
    
    result.join("\n")
  end

  def update_kitabu_config(temp_dir, section_title)
    config_path = File.join(temp_dir, 'config', 'kitabu.yml')
    config = YAML.load_file(config_path)
    
    # Update title and metadata for this section
    config['title'] = section_title
    config['uid'] = "solo-aviation-#{sanitize_filename(section_title).downcase}-#{Time.now.strftime('%Y%m%d')}"
    config['identifier']['id'] = "solo-aviation-#{sanitize_filename(section_title).downcase}"
    
    # Add custom template and CSS for individual sections
    config['templates'] = {
      'html' => 'section_layout.erb'
    }
    config['styles'] = {
      'pdf' => 'section_pdf.css'
    }
    
    File.write(config_path, config.to_yaml)
    
    # Also update the HTML template to use our custom layout
    html_template_path = File.join(temp_dir, 'templates', 'html', 'layout.erb')
    if File.exist?(html_template_path)
      FileUtils.cp(File.join(temp_dir, 'templates', 'html', 'section_layout.erb'), html_template_path)
    end
    
    # Update the PDF CSS to use our custom styling
    pdf_css_path = File.join(temp_dir, 'templates', 'styles', 'pdf.css')
    if File.exist?(pdf_css_path)
      FileUtils.cp(File.join(temp_dir, 'templates', 'styles', 'section_pdf.css'), pdf_css_path)
    end
  end

  def generate_pdf_with_kitabu(temp_dir, output_filename, chapter_dir_name)
    # Ensure output directory exists (use absolute path)
    output_path = File.expand_path(OUTPUT_DIR)
    FileUtils.mkdir_p(output_path)
    
    # Create chapter directory
    chapter_path = File.join(output_path, chapter_dir_name)
    FileUtils.mkdir_p(chapter_path)
    
    # Change to temporary directory and run kitabu
    Dir.chdir(temp_dir) do
      # Try to use Prince XML directly if available, otherwise fall back to kitabu
      if system('which prince > /dev/null 2>&1')
        # Use Prince XML directly with our custom HTML
        html_file = 'text/01_section.html'
        css_file = 'templates/styles/section_pdf.css'
        if File.exist?(html_file) && File.exist?(css_file)
          result = system("prince #{html_file} -o output/section.pdf --style=#{css_file} 2>/dev/null")
          if result && File.exist?('output/section.pdf')
            FileUtils.cp('output/section.pdf', File.join(chapter_path, output_filename))
            return true
          end
        end
      end
      
      # Fallback to kitabu export
      result = system('bundle exec kitabu export --only=pdf')
      
      # Look for any PDF files in the output directory
      pdf_files = Dir.glob('output/*.pdf')
      
      if result && pdf_files.any?
        # Use the first PDF file found
        source_pdf = pdf_files.first
        target_path = File.join(chapter_path, output_filename)
        FileUtils.cp(source_pdf, target_path)
        true
      else
        false
      end
    end
  rescue StandardError => e
    puts "      ⚠️  Error generating PDF: #{e.message}"
    false
  end

  def sanitize_filename(filename)
    # Remove or replace characters that aren't safe for filenames
    filename.gsub(/[^a-zA-Z0-9\s\-_]/, '')
            .gsub(/\s+/, '_')
            .gsub(/_+/, '_')
            .gsub(/^_|_$/, '')
  end

  def generate_summary_report
    puts ""
    puts "📊 Generating summary report..."
    
    report_content = "# Section PDF Generation Report\n\n"
    report_content += "Generated on: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}\n\n"
    report_content += "Total PDFs generated: #{@generated_pdfs.length}\n\n"
    report_content += "**Note**: PDFs are now organized in separate chapter directories for better navigation.\n\n"
    
    # Group by section
    grouped_pdfs = @generated_pdfs.group_by { |pdf| pdf[:section] }
    
    grouped_pdfs.each do |section_name, pdfs|
      report_content += "## #{section_name}\n\n"
      pdfs.each do |pdf|
        size_mb = pdf[:size] ? (pdf[:size] / 1024.0 / 1024.0).round(2) : 'Unknown'
        report_content += "- **#{pdf[:title]}** → `#{pdf[:chapter_dir]}/#{pdf[:filename]}` (#{size_mb} MB)\n"
      end
      report_content += "\n"
    end
    
    # Write report
    File.write(OUTPUT_DIR.join('generation_report.md'), report_content)
    puts "  ✅ Report saved: #{OUTPUT_DIR}/generation_report.md"
  end
end

# Run the generator if this file is executed directly
if __FILE__ == $PROGRAM_NAME
  generator = SectionPDFGenerator.new
  generator.generate_all_section_pdfs!
end

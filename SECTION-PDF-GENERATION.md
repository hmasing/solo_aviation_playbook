# Individual Section PDF Generation

This document describes how to generate individual PDF files for each section within each chapter of the Solo Aviation Services Playbook.

## Overview

In addition to the main playbook PDF, you can now generate separate PDF files for each individual section/procedure. This is useful for:

- **Training Materials**: Distribute specific procedures to team members
- **Reference Documents**: Quick access to individual procedures
- **Client Handouts**: Share specific procedures with clients
- **Compliance Documentation**: Provide specific procedures to auditors or inspectors

## Quick Start

### Generate All Section PDFs

```bash
# Using Ruby script
ruby build_section_pdfs.rb

# Or using shell script
./build_section_pdfs.sh
```

### Generate Individual Section PDFs

```bash
# Direct generation
ruby generate_section_pdfs.rb
```

## Generated Files

### Output Location
All individual section PDFs are generated in the `./section-pdfs/` directory.

### File Naming Convention
PDFs are named using the pattern: `{Chapter_Name}_{Section_Title}.pdf`

Examples:
- `FBO_Services_Aircraft_Arrival_Departure_Handling.pdf`
- `Maintenance_Operations_Aircraft_Inspection_Procedures.pdf`
- `Safety_and_Compliance_Emergency_Response_Procedures.pdf`

### Generation Report
A detailed report is generated at `./section-pdfs/generation_report.md` containing:
- Total number of PDFs generated
- List of all generated files organized by chapter
- File sizes for each PDF
- Generation timestamp

## What Gets Generated

### Chapter Overviews
If a chapter has a `00-chapter-overview.md` file and `include_overview: true` is set in the chapter configuration, a separate PDF is generated for the chapter overview.

### Individual Procedures
Each procedure file (numbered files like `01-procedure-name.md`, `02-procedure-name.md`, etc.) generates its own PDF.

### PDF Format
Individual section PDFs are optimized for standalone use:
- **No Cover Page**: Removes front cover to focus on content
- **No Table of Contents**: Eliminates TOC since each PDF contains only one section
- **Page Numbers**: Includes page numbers in footer starting from page 1
- **Professional Footers**: Includes Solo Aviation logo and page numbering
- **No Useless First Page**: Content starts immediately without blank pages
- **Professional Styling**: Uses custom CSS optimized for individual sections

### Excluded Files
The following files are **not** included in individual PDF generation:
- `README.md` files
- Files with `00-chapter-overview.md` (handled separately as overview PDFs)

## Configuration

### Chapter Configuration
The generation process uses the same configuration file as the main playbook: `./config/chapter_order.yml`

Key settings that affect individual PDF generation:
- `enabled: true/false` - Controls whether the entire chapter is processed
- `include_overview: true/false` - Controls whether chapter overview PDFs are generated
- `title: "Custom Title"` - Used in PDF filenames and titles

### Example Configuration
```yaml
chapters:
  - directory: "fbo-services"
    title: "FBO Services"
    enabled: true
    include_overview: true
    description: "Client-facing operations"
```

## Technical Details

### How It Works
1. **Content Discovery**: Scans the `./content/` directory for chapters and procedures
2. **Temporary Projects**: Creates temporary Kitabu projects for each section
3. **PDF Generation**: Uses Kitabu to generate individual PDFs
4. **Cleanup**: Removes temporary files after generation
5. **Reporting**: Creates a summary report of all generated files

### Custom Templates and Styling
The system uses specialized templates for individual section PDFs:
- **Custom HTML Template**: `kitabu/templates/html/section_layout.erb` - Excludes cover and TOC
- **Custom PDF CSS**: `kitabu/templates/styles/section_pdf.css` - Optimized styling for individual sections
- **Page Numbering**: Starts from page 1 for each individual PDF
- **Professional Layout**: Maintains consistent styling with main playbook

### Dependencies
- Ruby (with ActiveSupport)
- Kitabu gem (already configured in the project)
- Existing playbook structure and content

### Performance Considerations
- Generation time scales with the number of procedures
- Each PDF is generated independently, so failures in one don't affect others
- Temporary files are cleaned up automatically
- Memory usage is minimal as only one section is processed at a time

## Troubleshooting

### Common Issues

#### "generate_section_pdfs.rb not found"
- Ensure you're running the script from the playbook root directory
- Check that the file exists and has proper permissions

#### "kitabu directory not found"
- Ensure the Kitabu project is properly set up
- Run the main playbook build first to verify Kitabu is working

#### "content directory not found"
- Verify the content directory structure is intact
- Check that `./config/chapter_order.yml` exists and is properly configured

#### PDF Generation Failures
- Check that Kitabu dependencies are installed (`bundle install` in kitabu directory)
- Verify that individual markdown files are valid
- Check for any special characters in filenames that might cause issues

### Debug Mode
To see more detailed output during generation, you can modify the scripts to include debug information or run individual components manually.

## Integration with Main Playbook

### Workflow Integration
The individual section PDF generation is designed to work alongside the main playbook generation:

1. **Main Playbook**: `ruby build_playbook.rb` or `./build_playbook.sh`
2. **Section PDFs**: `ruby build_section_pdfs.rb` or `./build_section_pdfs.sh`

Both can be run independently or in sequence.

### Content Synchronization
- Both systems use the same source content from `./content/`
- Both use the same configuration from `./config/chapter_order.yml`
- Changes to content automatically affect both main playbook and individual PDFs

## Best Practices

### Content Organization
- Keep procedure files focused and self-contained
- Use clear, descriptive titles in markdown headers
- Ensure all procedures include proper frontmatter

### File Management
- Regularly clean up old section PDFs if not needed
- Archive important versions of individual PDFs
- Use the generation report to track what was created

### Distribution
- Consider which procedures need to be distributed individually
- Use descriptive filenames for easy identification
- Maintain a master list of distributed procedures

## Future Enhancements

Potential improvements for the section PDF generation system:

- **Selective Generation**: Generate PDFs for specific chapters or procedures only
- **Custom Styling**: Different PDF styles for different types of procedures
- **Batch Operations**: Generate PDFs for multiple procedures with shared settings
- **Integration**: Direct integration with document management systems
- **Automation**: Scheduled generation of updated PDFs when content changes

---

**Document Owner**: Operations Management  
**Last Updated**: 2025-01-27  
**Version**: 1.0

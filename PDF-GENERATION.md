# PDF Generation for Solo Aviation Services Playbook

This document explains how to generate PDF versions of the Solo Aviation Services Playbook using Kitabu.

## Quick Start

### Generate PDF (Simple)
```bash
./build_playbook.sh
```

### Generate PDF (Ruby)
```bash
ruby build_playbook.rb
```

### Manual Generation
```bash
cd solo-aviation-services-playbook
ruby organize_content.rb
bundle exec kitabu export --only=pdf
```

## Setup Details

### Initial Setup (Already Complete)
The Kitabu environment has been set up in the `solo-aviation-services-playbook/` directory with:

- ✅ **Kitabu gem installed**
- ✅ **Project structure created**
- ✅ **Configuration customized** for FBO playbook
- ✅ **Content organization script** created
- ✅ **Build scripts** for easy PDF generation

### File Structure
```
playbook/
├── build_playbook.rb          # Ruby build script
├── build_playbook.sh          # Shell build script  
└── solo-aviation-services-playbook/   # Kitabu project
    ├── config/
    │   └── kitabu.yml         # Book configuration
    ├── text/                  # Organized content files
    ├── templates/             # Styling templates
    ├── output/                # Generated files
    │   ├── solo-aviation-services-playbook.pdf  # Main PDF
    │   └── solo-aviation-services-playbook.html # HTML version
    └── organize_content.rb    # Content organization script
```

## Generated Output

The build process creates several files in `solo-aviation-services-playbook/output/`:

- **`solo-aviation-services-playbook.pdf`** - Main PDF document
- **`solo-aviation-services-playbook.html`** - HTML version
- **`solo-aviation-services-playbook.print.pdf`** - Print-optimized PDF
- Supporting assets (images, styles)

## Content Organization

The `organize_content.rb` script automatically:

1. **Clears old content** from the Kitabu text directory
2. **Copies and processes** your main playbook files:
   - Introduction (README.md)
   - All 6 operational sections
   - Content guidelines
   - Template reference
3. **Cleans up formatting**:
   - Removes navigation links
   - Strips YAML frontmatter
   - Fixes relative links
   - Removes extra whitespace
4. **Copies assets** (images) to the appropriate location

## Customization

### Styling
Edit these files to customize the PDF appearance:
- `templates/styles/pdf.css` - PDF-specific styling
- `templates/styles/print.css` - Print version styling
- `templates/styles/html.css` - HTML version styling

### Book Configuration
Edit `config/kitabu.yml` to change:
- Title and metadata
- Copyright information
- Author details
- Publication information

### Content Structure
Modify `organize_content.rb` to:
- Change section order
- Add/remove sections
- Customize content processing
- Include additional files

## Other Export Formats

Kitabu can generate multiple formats:

```bash
# HTML version
bundle exec kitabu export --only=html

# EPUB version  
bundle exec kitabu export --only=epub

# All formats
bundle exec kitabu export
```

## Automation

### Adding to Your Workflow

You can integrate PDF generation into your development workflow:

1. **Git hooks** - Generate PDF on commit/push
2. **CI/CD pipeline** - Auto-generate and distribute PDFs
3. **Scheduled builds** - Regular PDF updates
4. **Watch mode** - Auto-rebuild on file changes

### Example Git Hook
Create `.git/hooks/post-commit`:
```bash
#!/bin/bash
echo "Generating updated Solo Aviation Services Playbook PDF..."
./build_playbook.sh
```

## Troubleshooting

### Common Issues

**Missing dependencies:**
```bash
cd solo-aviation-services-playbook
bundle install
```

**PDF generation fails:**
- Check that all Markdown files are valid
- Ensure no broken internal links
- Verify images exist in the assets directory

**Styling issues:**
- Edit `templates/styles/pdf.css`
- Check CSS syntax
- Test with HTML export first

**Content not updating:**
- Run `organize_content.rb` manually
- Check source file permissions
- Verify paths in the organization script

### Getting Help

- **Kitabu documentation**: [GitHub repository](https://github.com/fnando/kitabu)
- **Ruby/Bundler issues**: Check your Ruby version and gem environment
- **CSS styling**: Use browser developer tools with HTML export

## Future Enhancements

Potential improvements to consider:

1. **Custom cover page** with FBO branding
2. **Table of contents** styling improvements
3. **Cross-reference handling** for internal links
4. **Automated asset optimization** (image compression)
5. **Multi-format build pipeline** (PDF, EPUB, HTML)
6. **Integration with documentation tools** (like GitBook or Notion)

---

**Last Updated**: January 2025  
**Maintained By**: FBO Operations Team  
**Generated With**: Kitabu 3.1.0

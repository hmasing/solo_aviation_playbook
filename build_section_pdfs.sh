#!/bin/bash
# build_section_pdfs.sh - Shell script to generate individual section PDFs

echo "🛩️  Building Individual Section PDFs for Solo Aviation Services Playbook..."
echo ""

# Check if we're in the right directory
if [ ! -f "generate_section_pdfs.rb" ]; then
    echo "❌ Error: generate_section_pdfs.rb not found in current directory"
    echo "   Please run this script from the playbook root directory"
    exit 1
fi

# Check if kitabu directory exists
if [ ! -d "kitabu" ]; then
    echo "❌ Error: kitabu directory not found"
    echo "   Please ensure the kitabu project is set up"
    exit 1
fi

# Check if content directory exists
if [ ! -d "content" ]; then
    echo "❌ Error: content directory not found"
    echo "   Please ensure the content directory exists"
    exit 1
fi

echo "📋 Prerequisites check passed!"
echo ""

# Run the section PDF generator
echo "🚀 Starting section PDF generation..."
echo ""

ruby generate_section_pdfs.rb

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ All section PDFs generated successfully!"
    echo ""
    echo "📁 Generated files are located in: ./section-pdfs/"
    echo "📊 Generation report: ./section-pdfs/generation_report.md"
    echo ""
    echo "🚀 To view all generated PDFs:"
    echo "   open ./section-pdfs/"
    echo ""
    echo "📖 To view the generation report:"
    echo "   open ./section-pdfs/generation_report.md"
else
    echo ""
    echo "❌ Section PDF generation failed. Check the output above for errors."
    exit 1
fi

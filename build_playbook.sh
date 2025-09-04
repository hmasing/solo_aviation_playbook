#!/bin/bash
# build_playbook.sh - Shell script version for building the Solo Aviation Services Playbook PDF

echo "🛩️  Building Solo Aviation Services Playbook..."
echo ""

# Change to the kitabu project directory
cd kitabu

echo "📋 Organizing latest content..."
ruby organize_content.rb

echo ""
echo "📖 Generating PDF..."
bundle exec kitabu export --only=pdf

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ PDF generated successfully!"
    
    # Copy PDF to root output directory for organized structure
    if [ -f "output/kitabu.pdf" ]; then
        mkdir -p "../output"
        if cp "output/kitabu.pdf" "../output/solo-aviation-services-playbook.pdf"; then
            echo "📄 Main playbook PDF copied to: output/solo-aviation-services-playbook.pdf"
            echo "📁 Original location: kitabu/output/kitabu.pdf"
        else
            echo "❌ Failed to copy main playbook PDF"
            exit 1
        fi
    else
        echo "⚠️  Main playbook PDF not found in expected location"
        exit 1
    fi
    
    # Return to root directory and generate individual section PDFs
    cd ..
    echo ""
    echo "🛩️  Generating individual section PDFs..."
    ruby build_section_pdfs.rb
    
    echo ""
    echo "🚀 To open the main playbook:"
    echo "   open output/solo-aviation-services-playbook.pdf"
    echo ""
    echo "🚀 To view all generated PDFs:"
    echo "   open output/"
else
    echo ""
    echo "❌ PDF generation failed. Check the output above for errors."
fi

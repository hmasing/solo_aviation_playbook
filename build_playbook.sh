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
    
    # Copy PDF to root directory for easy access
    if [ -f "output/kitabu.pdf" ]; then
        cp "output/kitabu.pdf" "../solo-aviation-services-playbook.pdf"
        echo "📄 PDF copied to root directory: solo-aviation-services-playbook.pdf"
        echo "📁 Original location: kitabu/output/"
        
        echo ""
        echo "🚀 To open the PDF:"
        echo "   open solo-aviation-services-playbook.pdf"
        echo "   # Or from original location: open kitabu/output/kitabu.pdf"
    else
        echo "⚠️  PDF not found in expected location"
    fi
else
    echo ""
    echo "❌ PDF generation failed. Check the output above for errors."
fi

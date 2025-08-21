#!/bin/bash
# build_playbook.sh - Shell script version for building the FBO Operations Playbook PDF

echo "🛩️  Building FBO Operations Playbook..."
echo ""

# Change to the kitabu project directory
cd fbo-operations-playbook

echo "📋 Organizing latest content..."
ruby organize_content.rb

echo ""
echo "📖 Generating PDF..."
bundle exec kitabu export --only=pdf

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ PDF generated successfully!"
    
    # Copy PDF to root directory for easy access
    if [ -f "output/fbo-operations-playbook.pdf" ]; then
        cp "output/fbo-operations-playbook.pdf" "../fbo-operations-playbook.pdf"
        echo "📄 PDF copied to root directory: fbo-operations-playbook.pdf"
        echo "📁 Original location: fbo-operations-playbook/output/"
        
        echo ""
        echo "🚀 To open the PDF:"
        echo "   open fbo-operations-playbook.pdf"
        echo "   # Or from original location: open fbo-operations-playbook/output/fbo-operations-playbook.pdf"
    else
        echo "⚠️  PDF not found in expected location"
    fi
else
    echo ""
    echo "❌ PDF generation failed. Check the output above for errors."
fi

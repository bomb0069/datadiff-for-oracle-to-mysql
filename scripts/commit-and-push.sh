#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}📝 Preparing comprehensive commit...${NC}"

# Check git status
echo -e "${YELLOW}🔍 Current git status:${NC}"
git status --porcelain

# Add all changes
git add -A

# Show what will be committed
echo -e "${YELLOW}📋 Files staged for commit:${NC}"
git diff --cached --name-status

echo -e "${BLUE}💾 Creating comprehensive commit with detailed message...${NC}"

# Create comprehensive commit message
git commit -m "Complete different fields comparison system implementation

🎯 Major Features Added:
- Enhanced export-results.sh with Option 7 for different fields testing
- Comprehensive multi-table schema comparison capabilities
- Professional HTML reports with schema visualization
- Cross-platform compatibility (host/container execution)

📊 Enhanced Export System:
- Added Option 7: Different Fields Comparison Test
- Improved menu display with better descriptions (1-7 options)
- Enhanced error handling and validation
- Better cross-environment execution detection

🔧 Technical Improvements:
- Complete TOML configuration for field-selective comparisons:
  * employees_common_fields: MySQL (10) vs Oracle (6) fields
  * categories_common_fields: MySQL (10) vs Oracle (4) fields  
  * employees_salary_diff: Focused salary comparison
- Enhanced test-different-fields.sh with detailed HTML reporting
- Professional schema comparison visualization

📝 Documentation Updates:
- DIFFERENT_FIELDS_COMPARISON.md: Complete Thai language guide
- Updated README.md with field-level comparison examples
- Enhanced export script documentation and usage examples

🎨 User Experience:
- Colorized terminal output with better formatting
- Interactive menu system with clear options
- Professional HTML reports with CSS styling
- Cross-platform script execution support

🚀 Production Ready Features:
- Handles tables with different field counts using columns parameter
- Supports legacy system migration scenarios  
- Generates multiple report formats (HTML, CSV, JSON, Markdown)
- Real-world use cases for data migration and validation

Files Modified:
- scripts/export-results.sh: Enhanced with Option 7 and better UX
- scripts/test-different-fields.sh: Comprehensive testing script
- datadiff.toml: Field-selective comparison configurations
- scripts/init-mysql.sql: Added employees and product_categories tables
- scripts/init-oracle.sql: Added corresponding tables with fewer fields
- DIFFERENT_FIELDS_COMPARISON.md: Complete documentation
- README.md: Updated with field-level comparison section

This completes the different fields comparison system, making it production-ready
for enterprise database migration and validation projects with different schemas."

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Commit successful!${NC}"
    
    echo -e "${BLUE}🚀 Pushing to remote repository...${NC}"
    git push origin main
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Push successful!${NC}"
        echo
        echo -e "${GREEN}🎉 Complete Different Fields Comparison System Deployed!${NC}"
        echo -e "${BLUE}📈 Repository Status: Up to date with comprehensive features${NC}"
        echo -e "${YELLOW}🔗 Features Available:${NC}"
        echo "   • Multi-schema table comparison (different field counts)"
        echo "   • Professional export system with 7 output options"
        echo "   • Thai language documentation and guides"  
        echo "   • Production-ready TOML configuration"
        echo "   • Cross-platform compatibility"
        echo
        echo -e "${GREEN}🚀 Ready for enterprise database comparison projects!${NC}"
    else
        echo -e "${RED}❌ Push failed!${NC}"
        exit 1
    fi
else
    echo -e "${RED}❌ Commit failed!${NC}"
    exit 1
fi
#!/bin/bash

# Universal data-diff multi-table comparison script
# Uses single config file without duplication
echo "🔍 Running data-diff multi-table comparison..."
echo "=============================================="
echo "Using single TOML configuration file (no duplication)"
echo ""

# Detect if we're running inside container or from host
if [ -f /.dockerenv ]; then
    # Running inside container - use mounted config
    CMD_PREFIX=""
    CONFIG_PATH="/config/datadiff.toml"
    echo "📍 Running from inside datadiff container"
else
    # Running from host - use docker exec with mounted config
    CMD_PREFIX="docker exec datadiff "
    CONFIG_PATH="/config/datadiff.toml"
    echo "📍 Running from host using docker exec"
fi

echo "📋 Configuration: $CONFIG_PATH (mounted from ./datadiff.toml)"
echo ""

echo "1. 👥 Employee comparison (identical data)..."
echo "---------------------------------------------"
${CMD_PREFIX}data-diff --conf $CONFIG_PATH --run employees_basic

echo ""
echo "2. 🏢 Departments comparison (identical data)..."
echo "------------------------------------------------"
${CMD_PREFIX}data-diff --conf $CONFIG_PATH --run departments_basic

echo ""
echo "3. 🚀 Projects comparison (with differences)..."
echo "-----------------------------------------------"
${CMD_PREFIX}data-diff --conf $CONFIG_PATH --run projects_basic

echo ""
echo "4. 📦 Products comparison (with differences)..."
echo "-----------------------------------------------"
${CMD_PREFIX}data-diff --conf $CONFIG_PATH --run products_basic

echo ""
echo "5. 📊 Employee stats (detailed output)..."
echo "-----------------------------------------"
${CMD_PREFIX}data-diff --conf $CONFIG_PATH --run employees_stats

echo ""
echo "6. 📦 Products with limit (row limit test)..."
echo "---------------------------------------------"
${CMD_PREFIX}data-diff --conf $CONFIG_PATH --run products_limited

echo ""
echo "✅ All multi-table comparisons completed!"
echo "========================================="
echo ""
echo "🎯 Summary of expected results:"
echo "- Employees: 0% difference (identical data)"
echo "- Departments: 0% difference (identical data)"  
echo "- Projects: Shows 1 difference (project budget)"
echo "- Products: Shows 1 difference (product price)"
echo "- Stats run: Detailed row counts and percentages"
echo "- Limited run: Same differences but with row limits"
echo ""

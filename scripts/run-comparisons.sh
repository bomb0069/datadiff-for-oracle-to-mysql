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

echo "1. � Products comparison (identical data)..."
echo "---------------------------------------------"
${CMD_PREFIX}data-diff --conf $CONFIG_PATH --run products_basic

echo ""
echo "2. 👥 Customers comparison (identical data)..."
echo "-----------------------------------------------"
${CMD_PREFIX}data-diff --conf $CONFIG_PATH --run customers_basic

echo ""
echo "3. � Orders comparison (identical data)..."
echo "-------------------------------------------"
${CMD_PREFIX}data-diff --conf $CONFIG_PATH --run orders_basic

echo ""
echo "4. � Products stats (detailed output)..."
echo "------------------------------------------"
${CMD_PREFIX}data-diff --conf $CONFIG_PATH --run products_stats

echo ""
echo "5. � Products with limit (row limit test)..."
echo "---------------------------------------------"
${CMD_PREFIX}data-diff --conf $CONFIG_PATH --run products_limited

echo ""
echo "6. 📦 Products with limit (row limit test)..."
echo "---------------------------------------------"
${CMD_PREFIX}data-diff --conf $CONFIG_PATH --run products_limited

echo ""
echo "✅ All multi-table comparisons completed!"
echo "========================================="
echo ""
echo "🎯 Summary of expected results:"
echo "- Products: 0% difference (identical data)"
echo "- Customers: 0% difference (identical data)"  
echo "- Orders: 0% difference (identical data)"
echo "- Stats run: Detailed row counts and percentages"
echo "- Limited run: Same data but with row limits"
echo ""

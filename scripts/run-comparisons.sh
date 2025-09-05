#!/bin/bash

# Universal data-diff multi-table comparison script
# Automatically discovers and runs all configured comparisons from TOML
echo "🔍 Running data-diff multi-table comparison..."
echo "=============================================="
echo "Auto-discovering all runs from TOML configuration"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Detect if we're running inside container or from host
if [ -f /.dockerenv ]; then
    # Running inside container - use mounted config
    CMD_PREFIX=""
    CONFIG_PATH="/config/datadiff.toml"
    LOCAL_CONFIG_PATH="/config/datadiff.toml"
    echo "📍 Running from inside datadiff container"
else
    # Running from host - use docker exec with mounted config
    CMD_PREFIX="docker exec datadiff "
    CONFIG_PATH="/config/datadiff.toml"
    LOCAL_CONFIG_PATH="./datadiff.toml"
    echo "📍 Running from host using docker exec"
fi

echo "📋 Configuration: $CONFIG_PATH (mounted from ./datadiff.toml)"
echo ""

# Function to extract run names from TOML config
get_run_names() {
    local config_file="$1"
    # Extract all [run.NAME] sections, excluding [run.default] and numbered subsections
    grep -E '^\[run\.[^.]+\]$' "$config_file" | \
    sed 's/^\[run\.\([^]]*\)\]$/\1/' | \
    grep -v '^default$' | \
    sort -u
}

# Function to get run description from comments
get_run_description() {
    local config_file="$1"
    local run_name="$2"
    # Look for comment above the run section
    local line_num=$(grep -n "^\[run\.$run_name\]" "$config_file" | cut -d: -f1)
    if [ -n "$line_num" ]; then
        # Get the line before the run section
        local prev_line=$((line_num - 1))
        local comment=$(sed -n "${prev_line}p" "$config_file" | sed 's/^# *//')
        if [ -n "$comment" ]; then
            echo "$comment"
        else
            echo "Comparison: $run_name"
        fi
    else
        echo "Comparison: $run_name"
    fi
}

# Get all run configurations
echo -e "${CYAN}🔍 Discovering comparison runs...${NC}"
RUN_NAMES=($(get_run_names "$LOCAL_CONFIG_PATH"))

if [ ${#RUN_NAMES[@]} -eq 0 ]; then
    echo -e "${RED}❌ No run configurations found in $LOCAL_CONFIG_PATH${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Found ${#RUN_NAMES[@]} comparison run(s):${NC}"
for run in "${RUN_NAMES[@]}"; do
    description=$(get_run_description "$LOCAL_CONFIG_PATH" "$run")
    echo -e "  ${YELLOW}•${NC} $run: $description"
done
echo ""

# Run all discovered comparisons
TOTAL_RUNS=${#RUN_NAMES[@]}
SUCCESSFUL_RUNS=0
FAILED_RUNS=0

for i in "${!RUN_NAMES[@]}"; do
    run_name="${RUN_NAMES[$i]}"
    run_number=$((i + 1))
    description=$(get_run_description "$LOCAL_CONFIG_PATH" "$run_name")
    
    echo -e "${WHITE}[$run_number/$TOTAL_RUNS]${NC} ${BLUE}$description${NC}"
    echo -e "${CYAN}Running: $run_name${NC}"
    echo "$(printf '%.0s-' {1..60})"
    
    # Execute the data-diff command
    if ${CMD_PREFIX}data-diff --conf $CONFIG_PATH --run $run_name; then
        echo -e "${GREEN}✅ Success: $run_name${NC}"
        ((SUCCESSFUL_RUNS++))
    else
        echo -e "${RED}❌ Failed: $run_name${NC}"
        ((FAILED_RUNS++))
    fi
    
    echo ""
done

# Summary
echo -e "${WHITE}✅ All comparisons completed!${NC}"
echo "==============================="
echo -e "${CYAN}📊 Summary:${NC}"
echo -e "  ${GREEN}• Successful runs: $SUCCESSFUL_RUNS${NC}"
if [ $FAILED_RUNS -gt 0 ]; then
    echo -e "  ${RED}• Failed runs: $FAILED_RUNS${NC}"
fi
echo -e "  ${BLUE}• Total runs: $TOTAL_RUNS${NC}"
echo ""

if [ $FAILED_RUNS -gt 0 ]; then
    echo -e "${YELLOW}⚠️  Some comparisons failed. Check the output above for details.${NC}"
    exit 1
else
    echo -e "${GREEN}🎉 All comparisons completed successfully!${NC}"
fi

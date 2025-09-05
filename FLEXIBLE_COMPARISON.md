# Flexible Data-diff Comparison System

## Overview

The `run-comparisons.sh` script has been enhanced to automatically discover and run all comparison configurations from the `datadiff.toml` file. This makes the system much more flexible and maintainable.

## How It Works

### 🔍 **Auto-Discovery**
- Scans `datadiff.toml` for all `[run.NAME]` sections
- Excludes `[run.default]` and numbered subsections (like `[run.NAME.1]`)
- Automatically extracts run descriptions from comments
- Runs all discovered comparisons in alphabetical order

### 🎯 **Key Benefits**
1. **No Code Changes**: Add new comparisons by just updating the TOML file
2. **Self-Documenting**: Uses comments above run sections as descriptions
3. **Error Handling**: Reports success/failure for each comparison
4. **Summary**: Shows total runs, successes, and failures
5. **Colorized Output**: Easy to read terminal output with progress indicators

## Usage

### Running All Comparisons
```bash
# Run all configured comparisons automatically
./scripts/run-comparisons.sh
```

### Adding New Comparisons

Simply add new sections to `datadiff.toml`:

```toml
# New comparison description
[run.new_comparison_name]
key_columns = ["id", "ID"]
stats = true

[run.new_comparison_name.1]
database = "mysql_test" 
table = "your_table"

[run.new_comparison_name.2]
database = "oracle_test"
table = "YOUR_TABLE"
```

The script will automatically:
- Discover the new comparison
- Extract "New comparison description" as the display name
- Include it in the next run

### Example Output

```
🔍 Running data-diff multi-table comparison...
==============================================
Auto-discovering all runs from TOML configuration

📍 Running from host using docker exec
📋 Configuration: /config/datadiff.toml (mounted from ./datadiff.toml)

🔍 Discovering comparison runs...
✅ Found 6 comparison run(s):
  • all_tables_summary: All tables comparison (comprehensive test)
  • customers_basic: Customers comparison (identical data)
  • orders_basic: Orders comparison (identical data)
  • products_basic: Products comparison (identical data)
  • products_limited: Products comparison with limit
  • products_stats: Products comparison with detailed stats

[1/6] All tables comparison (comprehensive test)
Running: all_tables_summary
------------------------------------------------------------
[comparison output...]
✅ Success: all_tables_summary

[2/6] Customers comparison (identical data)
Running: customers_basic
------------------------------------------------------------
[comparison output...]
✅ Success: customers_basic

...

✅ All comparisons completed!
===============================
📊 Summary:
  • Successful runs: 6
  • Total runs: 6

🎉 All comparisons completed successfully!
```

## Configuration Examples

### Basic Comparison
```toml
# Basic table comparison
[run.simple_test]
key_columns = ["id", "ID"]

[run.simple_test.1]
database = "mysql_test"
table = "table_name"

[run.simple_test.2]
database = "oracle_test"
table = "TABLE_NAME"
```

### Statistical Analysis
```toml
# Statistical comparison with detailed metrics
[run.stats_analysis]
key_columns = ["id", "ID"]
stats = true

[run.stats_analysis.1]
database = "mysql_test"
table = "products"

[run.stats_analysis.2]
database = "oracle_test"
table = "PRODUCTS"
```

### Limited Row Comparison
```toml
# Sample comparison with row limit
[run.sample_check]
key_columns = ["id", "ID"]
limit = 100

[run.sample_check.1]
database = "mysql_test"
table = "large_table"

[run.sample_check.2]
database = "oracle_test"
table = "LARGE_TABLE"
```

## Supported Features

- ✅ **Auto-discovery** of all run configurations
- ✅ **Comment-based descriptions** extracted automatically
- ✅ **Progress tracking** with [N/Total] indicators
- ✅ **Success/failure tracking** with colored output
- ✅ **Summary statistics** at completion
- ✅ **Error handling** with appropriate exit codes
- ✅ **Container detection** (works inside container or from host)
- ✅ **Flexible configuration** - no script changes needed

## Best Practices

1. **Use descriptive comments** above each `[run.NAME]` section
2. **Follow naming conventions** for run names (lowercase, underscores)
3. **Test new configurations** individually first
4. **Use appropriate key_columns** for your data structure
5. **Consider performance** with large tables (use limits when needed)

This flexible system allows you to easily manage complex data comparison scenarios without modifying any scripts - just update the TOML configuration file!

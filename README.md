# Data-diff Multi-table Compare: MySQL vs Oracle

A demonstration of using `data-diff` to compare data between MySQL and Oracle databases using Docker Compose with automated data initialization.

## 🔧 Quick Start

Start all services with automated data initialization:

```bash
docker-compose up -d --build
```

This automatically:

- Starts MySQL and Oracle databases
- Creates the `products`, `customers`, and `orders` tables in both databases
- Loads sample data with intentional differences for testing
- Starts the data-diff comparison container

## ✅ Run Database Comparison

### Universal Script (works from host or container)

```bash
# From host (auto-detects and uses docker exec)
./scripts/run-comparisons.sh

# Or from inside container
docker exec datadiff /scripts/run-comparisons.sh
```

This runs comprehensive multi-table comparisons using native `data-diff --conf` with TOML configuration only (no inline parameters).

## 🎯 Test Results

Our multi-table demo includes comparison scenarios:

| Table       | MySQL Rows | Oracle Rows | Differences   | Status             |
| ----------- | ---------- | ----------- | ------------- | ------------------ |
| `products`  | 7          | 6           | 3 differences | ⚠️ Price & missing |
| `customers` | 6          | 6           | 2 differences | ⚠️ Email & ID      |
| `orders`    | 7          | 7           | 3 differences | ⚠️ Quantity & IDs  |

**Expected Differences:**

- **Products**: Price differences (Laptop Pro $1299.99→$1399.99, Gaming Chair $199.99→$249.99), Standing Desk missing in Oracle
- **Customers**: Email differences (jane@example.com → jane.smith@example.com), different customer IDs (6 vs 7)
- **Orders**: Quantity differences (Order 4: 1→2), missing/extra orders (7 vs 8)

## 🎨 Beautiful Export Formats

Export comparison results in multiple professional formats:

```bash
# Interactive export menu
./scripts/export-results.sh

# Direct format selection (1-6)
echo "3" | ./scripts/export-results.sh  # HTML report
echo "6" | ./scripts/export-results.sh  # All formats
```

### Available Export Formats

| Format          | File Extension | Use Case        | Features                            |
| --------------- | -------------- | --------------- | ----------------------------------- |
| **🖥️ Terminal** | `.txt`         | Command line    | Colorized output, real-time viewing |
| **📄 JSON**     | `.json`        | API integration | Machine readable, structured data   |
| **🌐 HTML**     | `.html`        | Web reports     | Interactive, styled, charts         |
| **📊 CSV**      | `.csv`         | Spreadsheets    | Excel/Sheets compatible             |
| **📝 Markdown** | `.md`          | Documentation   | GitHub/Wiki ready, formatted tables |

### Export Features

- **📅 Timestamped files**: `datadiff_report_YYYYMMDD_HHMMSS.html`
- **📊 Executive summaries**: Statistics cards and overview
- **🎨 Professional styling**: CSS-styled HTML reports
- **📋 Detailed breakdowns**: Per-table analysis with differences
- **🔍 Expected vs Actual**: Validation against known test data
- **📁 Organized output**: All files saved to `./results/` directory

### Sample HTML Report

The HTML export creates a professional web report with:

```html
✅ Executive Summary Dashboard - 📋 6 Tables Compared - ✅ 2 Identical Tables -
⚠️ 4 Tables with Differences - 🔍 4 Total Differences Found 📋 Detailed Results
per Table - Color-coded status indicators - Difference highlights and details -
Responsive grid layout - Professional styling
```

### Sample CSV Export

Perfect for spreadsheet analysis:

```csv
Table,Description,MySQL_Rows,Oracle_Rows,Differences,Percentage,Status,Details
products_basic,Product Records,7,6,3,42.86%,Different,"Price differences in rows 1&5; Missing row 7 in Oracle"
customers_basic,Customer Records,6,6,2,33.33%,Different,"Email difference in row 2; Different customer in row 6/7"
orders_basic,Order Records,7,7,3,42.86%,Different,"Quantity difference in row 4; Missing row 7; Added row 8"
```

### Sample Markdown Export

GitHub-ready documentation:

```markdown
# 🔍 Data-diff Comparison Report

## 📊 Executive Summary

| Metric                     | Count |
| -------------------------- | ----- |
| 📋 Tables Compared         | 3     |
| ✅ Identical Tables        | 0     |
| ⚠️ Tables with Differences | 3     |

## ⚠️ Tables with Differences

| Table             | Differences | Details                              |
| ----------------- | ----------- | ------------------------------------ |
| `products_basic`  | 3 (42.86%)  | Price differences and missing record |
| `customers_basic` | 2 (33.33%)  | Email differences and different IDs  |
| `orders_basic`    | 3 (42.86%)  | Quantity and missing/extra orders    |
```

## 🔍 How It Works

The comparison uses `data-diff` with native TOML configuration only:

```bash
# Universal script - auto-detects environment
./scripts/run-comparisons.sh
```

**Features:**

- **Auto-discovery**: Automatically detects all comparison runs from TOML config
- **Universal script**: Works from host or inside container
- **Flexible configuration**: Add new comparisons by just updating TOML file
- **Multiple scenarios**: Statistical analysis, row limits, and basic comparisons
- **Cross-database**: Compares MySQL and Oracle with proper key column handling

**Output includes:**

- Row counts and statistics summary
- Percentage difference scores
- Exact differences when data varies
- Expected results summary

## 📁 Configuration

### Single Source of Truth

The demo uses **one configuration file** with **no duplication**:

- **Source & Active**: `./datadiff.toml` (mounted as `/config/datadiff.toml` in container)
- **No Copying**: Direct volume mount eliminates file duplication
- **Auto-Sync**: Changes in host file immediately available in container

### TOML Configuration Structure

Data-diff uses a specific TOML format with numbered sources (`1` and `2`) for each comparison run:

```toml
# Database definitions (reusable connection configs)
[database.database_name]
driver = "mysql"     # or "oracle", "postgresql", etc.
host = "hostname"
user = "username"
password = "password"
# ... other connection parameters

# Default run settings (inherited by all runs)
[run.default]
key_columns = ["id"]
stats = true
threads = 2

# Specific comparison runs
[run.run_name.1]           # First source (numbered .1)
database = "mysql_test"    # Reference to reusable database connection
table = "products"

[run.run_name.2]           # Second source (numbered .2)
database = "oracle_test"   # Reference to reusable database connection
table = "PRODUCTS"         # Note: Oracle uses uppercase table names

[run.run_name]             # Run-specific settings
key_columns = ["id", "ID"] # Primary key columns for comparison
stats = true               # Include statistics summary
limit = 100                # Limit detailed results (optional)
```

### Current Configuration

Our `datadiff.toml` uses flexible auto-discovery with multiple comparison scenarios:

```toml
# Statistics-focused comparison
[run.compare_with_stats.1]
database = "mysql_test"
table = "products"

[run.compare_with_stats.2]
database = "oracle_test"
table = "PRODUCTS"

[run.compare_with_stats]
key_columns = ["id", "ID"]
stats = true

# Detailed comparison
[run.compare_detailed.1]
database = "mysql_test"
table = "customers"

[run.compare_detailed.2]
database = "oracle_test"
table = "CUSTOMERS"

[run.compare_detailed]
key_columns = ["id", "ID"]
limit = 100
```

### Key Configuration Options

| Option        | Description                                | Example                       |
| ------------- | ------------------------------------------ | ----------------------------- |
| `key_columns` | Primary key columns for row matching       | `["id"]` or `["id", "name"]`  |
| `stats`       | Include statistics summary                 | `true`                        |
| `limit`       | Limit number of detailed differences shown | `100`                         |
| `threads`     | Database worker threads                    | `4`                           |
| `where`       | Additional WHERE clause filter             | `"created_at > '2023-01-01'"` |
| `columns`     | Specific columns to compare                | `["name", "email"]`           |
| `verbose`     | Enable verbose logging                     | `true`                        |

### Environment Variables

The configuration supports environment variable substitution using `${VAR_NAME}` syntax:

```toml
[database.mysql_prod]
driver = "mysql"
host = "${MYSQL_HOST}"
user = "${MYSQL_USER}"
password = "${MYSQL_PASSWORD}"
```

### Multi-Table Comparison Examples

For comparing multiple tables across databases, you can define multiple run configurations in the same TOML file:

```toml
# Database definitions for reusability
[database.mysql_dev]
driver = "mysql"
host = "mysql-dev"
user = "test"
password = "test"
port = 3306
database = "testdb"

[database.oracle_prod]
driver = "oracle"
host = "oracle-prod"
user = "test"
password = "oracle"
port = 1521
database = "XE"

# Products comparison with statistics
[run.products_stats.1]
database = "mysql_test"
table = "products"

[run.products_stats.2]
database = "oracle_test"
table = "PRODUCTS"

[run.products_stats]
key_columns = ["id", "ID"]
stats = true

# Customers comparison (basic)
[run.customers_basic.1]
database = "mysql_test"
table = "customers"

[run.customers_basic.2]
database = "oracle_test"
table = "CUSTOMERS"

[run.customers_basic]
key_columns = ["id", "ID"]

# Orders comparison with row limit
[run.orders_limited.1]
database = "mysql_test"
table = "orders"

[run.orders_limited.2]
database = "oracle_test"
table = "ORDERS"

[run.orders_limited]
key_columns = ["id", "ID"]
limit = 5
database = "postgres_staging"
table = "transactions"

[run.transactions_comparison]
key_columns = ["transaction_id", "user_id"]
where = "created_at >= '2024-01-01'"
stats = true
threads = 8
limit = 1000
```

**Running multiple comparisons:**

```bash
# All comparisons are now handled by the unified script
./scripts/run-comparisons.sh

# Or run individual comparisons using the single config file
docker exec datadiff data-diff --conf /datadiff.toml --run employees_basic
docker exec datadiff data-diff --conf /datadiff.toml --run departments_basic
docker exec datadiff data-diff --conf /datadiff.toml --run projects_basic
docker exec datadiff data-diff --conf /datadiff.toml --run products_basic
```

**Cross-database comparison matrix:**

```toml
# Compare the same table across 3 different databases
[run.users_mysql_vs_oracle.1]
database = "mysql://user:pass@mysql-host:3306/db"
table = "users"

[run.users_mysql_vs_oracle.2]
database = "oracle://user:pass@oracle-host:1521/db"
table = "USERS"

[run.users_mysql_vs_oracle]
key_columns = ["user_id"]
stats = true

[run.users_oracle_vs_postgres.1]
database = "oracle://user:pass@oracle-host:1521/db"
table = "USERS"

[run.users_oracle_vs_postgres.2]
database = "postgresql://user:pass@postgres-host:5432/db"
table = "users"

[run.users_oracle_vs_postgres]
key_columns = ["user_id"]
stats = true

[run.users_mysql_vs_postgres.1]
database = "mysql://user:pass@mysql-host:3306/db"
table = "users"

[run.users_mysql_vs_postgres.2]
database = "postgresql://user:pass@postgres-host:5432/db"
table = "users"

[run.users_mysql_vs_postgres]
key_columns = ["user_id"]
stats = true
```

### References

- **Official Documentation**: [Datafold Data-diff Repository](https://github.com/datafold/data-diff) (archived as of May 2024)
- **Configuration Parser**: [`data_diff/config.py`](https://github.com/datafold/data-diff/blob/master/data_diff/config.py)
- **TOML Format Examples**: [`tests/test_config.py`](https://github.com/datafold/data-diff/blob/master/tests/test_config.py)
- **Command Line Usage**: `data-diff --conf datadiff.toml --run run_name`

**Note**: The numbered source format (`run.name.1` and `run.name.2`) is required for data-diff v0.10.0+ when using `--conf`. Direct URI strings or database references are supported for both sources.## 🔧 Manual Commands

You can also run data-diff commands directly:

````

```bash
# Using unified script (recommended)
./scripts/run-comparisons.sh

# Or using TOML configuration directly
docker exec datadiff data-diff --conf /datadiff.toml --run employees_basic
docker exec datadiff data-diff --conf /datadiff.toml --run employees_stats
````

## 🧪 Testing with Data Differences

Create test differences to verify the comparison works:

```bash
# Add a record to MySQL only
docker exec mysql-datadiff mysql -u test -ptest testdb -e \
  "INSERT INTO employees (id, name, email) VALUES (4, 'David', 'david@example.com');"

# Run comparison to see the difference
docker exec datadiff /scripts/compare.sh
```

**Expected output:** Shows 25% difference (1 out of 4 rows differs)

## 🏗️ Architecture

**Containers:**

- **MySQL 8.0** (port 3307): Test database with `employees` table
- **Oracle XE 21c** (port 1523): Test database with `EMPLOYEES` table
- **Data-diff**: Python 3.10 container with data-diff, pymysql, and oracledb

**Key Features:**

- Automated data initialization via Docker volumes
- Health checks ensure databases are ready before data-diff starts
- Case-sensitive table handling (MySQL: `employees`, Oracle: `EMPLOYEES`)

## 📂 Project Structure

```
datadiff-mysql-oracle-demo/
├── docker-compose.yml          # Container orchestration
├── README.md                   # This documentation
├── datadiff/
│   └── Dockerfile             # Data-diff container setup
└── scripts/
    ├── compare.sh             # Main comparison script
    ├── datadiff.toml          # TOML configuration
    ├── init-mysql.sql         # MySQL data initialization
    └── init-oracle.sql        # Oracle data initialization
```

## 💡 Key Benefits

**vs. Manual Shell Scripts:**

- ✅ **Automatic initialization**: Data loads when containers start
- ✅ **No manual steps**: Just run `docker-compose up -d`
- ✅ **Proper dependencies**: Data-diff waits for databases to be ready
- ✅ **Idempotent**: Safe to restart containers without data duplication

**vs. Custom Python Scripts:**

- ✅ **Professional tooling**: Uses industry-standard `data-diff`
- ✅ **Native configuration**: TOML-based configuration files
- ✅ **Advanced features**: Statistics, limits, filtering, and more
- ✅ **Maintenance**: No custom code to maintain

## 🚀 Quick Commands

```bash
# Start everything
docker-compose up -d --build

# Run comparison
docker exec datadiff /scripts/compare.sh

# Interactive shell
docker exec -it datadiff bash

# View logs
docker-compose logs datadiff

# Clean up
docker-compose down -v
```

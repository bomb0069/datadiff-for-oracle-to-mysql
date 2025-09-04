# Data-diff Multi-table Compare: MySQL vs Oracle

A demonstration of using `data-diff` to compare data between MySQL and Oracle databases using Docker Compose with automated data initialization.

## 🔧 Quick Start

Start all services with automated data initialization:

```bash
docker-compose up -d --build
```

This automatically:

- Starts MySQL and Oracle databases
- Creates the `employees` table in both databases
- Loads identical sample data into both databases
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

Our multi-table demo includes 6 different comparison scenarios:

| Table         | MySQL Rows | Oracle Rows | Differences  | Status             |
| ------------- | ---------- | ----------- | ------------ | ------------------ |
| `employees`   | 3          | 3           | 0 (0.00%)    | ✅ Identical       |
| `departments` | 3          | 3           | 0 (0.00%)    | ✅ Identical       |
| `projects`    | 3          | 3           | 1 difference | ⚠️ Budget mismatch |
| `products`    | 5          | 5           | 1 difference | ⚠️ Price mismatch  |

**Expected Differences:**

- **Projects**: Project 105 has different budget values (MySQL: 500000, Oracle: 550000)
- **Products**: Product 1005 has different prices (MySQL: 599.99, Oracle: 649.99)

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
employees_basic,Employee Records,3,3,0,0.00%,Identical,"All employee records match"
projects_basic,Project Records,3,3,1,33.33%,Different,"Project 105 budget differs: 500000 vs 550000"
```

### Sample Markdown Export

GitHub-ready documentation:

```markdown
# 🔍 Data-diff Comparison Report

## 📊 Executive Summary

| Metric                     | Count |
| -------------------------- | ----- |
| 📋 Tables Compared         | 6     |
| ✅ Identical Tables        | 2     |
| ⚠️ Tables with Differences | 4     |

## ⚠️ Tables with Differences

| Table            | Differences | Details                                 |
| ---------------- | ----------- | --------------------------------------- |
| `projects_basic` | 1 (33.33%)  | Project 105: budget `500000` → `550000` |
| `products_basic` | 1 (20.00%)  | Product 1005: price `599.99` → `649.99` |
```

## 🔍 How It Works

The comparison uses `data-diff` with native TOML configuration only:

```bash
# Universal script - auto-detects environment
./scripts/run-comparisons.sh
```

**Features:**

- **Config-only approach**: All parameters defined in `datadiff.toml` (no inline parameters)
- **Universal script**: Works from host or inside container
- **Multiple scenarios**: 6 different comparison runs covering all tables
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
database = "mysql://test:test@mysql-datadiff:3306/testdb"  # URI or database name
table = "employees"

[run.run_name.2]           # Second source (numbered .2)
database = "oracle://test:test@oracle-datadiff:1521/XEPDB1"
table = "EMPLOYEES"        # Note: Oracle uses uppercase table names

[run.run_name]             # Run-specific settings
key_columns = ["id"]       # Primary key columns for comparison
stats = true               # Include statistics summary
limit = 100                # Limit detailed results (optional)
threads = 4                # Database threads (optional)
```

### Current Configuration

Our `datadiff.toml` contains two comparison scenarios:

```toml
# Statistics-focused comparison
[run.compare_with_stats.1]
database = "mysql://test:test@mysql-datadiff:3306/testdb"
table = "employees"

[run.compare_with_stats.2]
database = "oracle://test:test@oracle-datadiff:1521/XEPDB1"
table = "EMPLOYEES"

[run.compare_with_stats]
key_columns = ["id"]
stats = true

# Detailed comparison
[run.compare_detailed.1]
database = "mysql://test:test@mysql-datadiff:3306/testdb"
table = "employees"

[run.compare_detailed.2]
database = "oracle://test:test@oracle-datadiff:1521/XEPDB1"
table = "EMPLOYEES"

[run.compare_detailed]
key_columns = ["id"]
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
password = "test"
port = 1521
service_name = "XEPDB1"

[database.postgres_staging]
driver = "postgresql"
host = "postgres-staging"
user = "test"
password = "test"
port = 5432
database = "testdb"

# Table 1: Employee comparison (MySQL vs Oracle)
[run.employees_comparison.1]
database = "mysql_dev"
table = "employees"

[run.employees_comparison.2]
database = "oracle_prod"
table = "EMPLOYEES"

[run.employees_comparison]
key_columns = ["id"]
stats = true
limit = 50

# Table 2: Department comparison (MySQL vs PostgreSQL)
[run.departments_comparison.1]
database = "mysql_dev"
table = "departments"

[run.departments_comparison.2]
database = "postgres_staging"
table = "departments"

[run.departments_comparison]
key_columns = ["dept_id"]
columns = ["dept_name", "manager_id", "budget"]
stats = true

# Table 3: Projects comparison (Oracle vs PostgreSQL)
[run.projects_comparison.1]
database = "oracle_prod"
table = "PROJECTS"

[run.projects_comparison.2]
database = "postgres_staging"
table = "projects"

[run.projects_comparison]
key_columns = ["project_id"]
where = "status = 'ACTIVE'"
stats = true
threads = 2

# Table 4: Large table with performance tuning
[run.transactions_comparison.1]
database = "mysql_dev"
table = "transactions"

[run.transactions_comparison.2]
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

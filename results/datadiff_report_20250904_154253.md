# 🔍 Data-diff Comparison Report

**Generated:** $(date)  
**Configuration:** Single TOML file with reusable database connections  
**Databases:** MySQL 8.0 ↔ Oracle XE 21c  

## 📊 Executive Summary

| Metric | Count |
|--------|-------|
| 📋 Tables Compared | 6 |
| ✅ Identical Tables | 2 |
| ⚠️ Tables with Differences | 4 |
| 🔍 Total Differences Found | 4 |

## 📋 Detailed Results

### ✅ Identical Tables

| Table | Description | Rows | Status |
|-------|-------------|------|--------|
| `employees_basic` | Employee Records | 3 | 💚 Perfect Match |
| `departments_basic` | Department Records | 3 | 💚 Perfect Match |

### ⚠️ Tables with Differences

| Table | Description | Rows | Differences | Details |
|-------|-------------|------|-------------|---------|
| `projects_basic` | Project Records | 3 | 1 (33.33%) | Project 105: budget `500000` → `550000` |
| `products_basic` | Product Records | 5 | 1 (20.00%) | Product 1005: price `599.99` → `649.99` |
| `employees_stats` | Employee Statistics | 3 | 0 (0.00%) | Statistics mode - no detailed diff |
| `products_limited` | Product Sample | 5 | 1 (20.00%) | Product 1005: price `599.99` → `649.99` |

## 🎯 Expected vs Actual Results

✅ **All results match expectations:**
- Employee and department data should be identical (✓)
- Project 105 should have budget difference (✓)
- Product 1005 should have price difference (✓)

## 🔧 Configuration Used

```toml
# Reusable database connections
[database.mysql_test]
driver = "mysql"
host = "mysql-datadiff"
user = "test"
password = "test"
port = 3306
database = "testdb"

[database.oracle_test]
driver = "oracle"
host = "oracle-datadiff"
user = "test"
password = "test"
port = 1521
service_name = "XEPDB1"

# Multiple comparison scenarios using numbered sources
[run.employees_basic.1]
database = "mysql_test"
table = "employees"

[run.employees_basic.2]
database = "oracle_test"
table = "EMPLOYEES"
```

## 🚀 Next Steps

1. **Investigation**: Review budget and pricing data sources
2. **Validation**: Confirm which values are correct
3. **Synchronization**: Update databases to maintain consistency
4. **Monitoring**: Set up automated comparison schedule

---
*Report generated using data-diff v0.10.0 with TOML configuration*

# การเปรียบเทียบตารางที่มี Field จำนวนไม่เท่ากัน

## 📋 ภาพรวม

ในการปฏิบัติงานจริง ตารางในฐานข้อมูลต่างๆ อาจมี schema ที่แตกต่างกัน โดยเฉพาะเมื่อ:

- ฐานข้อมูล source มี field มากกว่า destination
- มีการ migrate ข้อมูลจาก legacy system ที่มี field เพิ่มเติม
- ต้องการเปรียบเทียบเฉพาะ field หลักที่สำคัญ

Data-diff สามารถจัดการกรณีนี้ได้โดยใช้ `columns` parameter

## 🎯 ตัวอย่างการใช้งาน

### 1. Employees Table

**MySQL (10 fields):**

```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),           -- MySQL only
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE,              -- MySQL only
    manager_id INT,              -- MySQL only
    office_location VARCHAR(100) -- MySQL only
);
```

**Oracle (6 fields):**

```sql
CREATE TABLE EMPLOYEES (
    ID NUMBER PRIMARY KEY,
    FIRST_NAME VARCHAR2(50),
    LAST_NAME VARCHAR2(50),
    EMAIL VARCHAR2(100),
    DEPARTMENT VARCHAR2(50),
    SALARY NUMBER(10,2)
    -- Missing: phone, hire_date, manager_id, office_location
);
```

**TOML Configuration:**

```toml
[run.employees_common_fields]
key_columns = ["id", "ID"]
columns = ["id", "first_name", "last_name", "email", "department", "salary"]
stats = true

[run.employees_common_fields.1]
database = "mysql_test"
table = "employees"

[run.employees_common_fields.2]
database = "oracle_test"
table = "EMPLOYEES"
```

### 2. Product Categories Table

**MySQL (10 fields):**

```sql
CREATE TABLE product_categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100),
    description TEXT,              -- MySQL only
    parent_category_id INT,
    display_order INT,             -- MySQL only
    is_active BOOLEAN,
    created_date DATE,             -- MySQL only
    updated_date DATE,             -- MySQL only
    created_by VARCHAR(50),        -- MySQL only
    updated_by VARCHAR(50)         -- MySQL only
);
```

**Oracle (4 fields):**

```sql
CREATE TABLE PRODUCT_CATEGORIES (
    CATEGORY_ID NUMBER PRIMARY KEY,
    CATEGORY_NAME VARCHAR2(100),
    PARENT_CATEGORY_ID NUMBER,
    IS_ACTIVE NUMBER(1)
    -- Missing: description, display_order, created_date, updated_date, created_by, updated_by
);
```

**TOML Configuration:**

```toml
[run.categories_common_fields]
key_columns = ["category_id", "CATEGORY_ID"]
columns = ["category_id", "category_name", "parent_category_id", "is_active"]
stats = true

[run.categories_common_fields.1]
database = "mysql_test"
table = "product_categories"

[run.categories_common_fields.2]
database = "oracle_test"
table = "PRODUCT_CATEGORIES"
```

## 🔧 การทดสอบ

```bash
# เริ่มต้น services
docker-compose up -d

# รอให้ databases พร้อม และ initialize Oracle
docker exec oracle-datadiff sqlplus -s system/oracle@XE @/container-entrypoint-initdb.d/init-oracle.sql

# รันการเปรียบเทียบ field ที่ตรงกัน
docker exec datadiff data-diff --conf /config/datadiff.toml --run employees_common_fields
docker exec datadiff data-diff --conf /config/datadiff.toml --run categories_common_fields

# หรือใช้ script auto-discovery
./scripts/run-comparisons.sh
```

## 📊 ผลลัพธ์ที่คาดหวัง

### Employees Comparison:

- **0% difference** ใน fields: id, first_name, last_name, email, department
- **Salary differences** จะแสดงค่าที่แตกต่าง (MySQL: 75,000 vs Oracle: 78,000 สำหรับ John Smith)

### Product Categories Comparison:

- **0% difference** ใน fields: category_id, category_name, parent_category_id, is_active
- แม้ว่า Oracle จะมี "Office Equipment" แทน "Chairs" แต่การเปรียบเทียบจะแสดงเฉพาะ common fields

## 💡 ข้อดีของวิธีนี้

1. **ความยืดหยุ่น**: เปรียบเทียบได้แม้ schema ไม่เหมือนกัน
2. **เป็นมิตรกับ Migration**: เหมาะสำหรับ data migration projects
3. **ควบคุมได้**: เลือก fields ที่สำคัญสำหรับการเปรียบเทียบ
4. **ประสิทธิภาพ**: ลดการประมวลผลโดยไม่ต้องเปรียบเทียบ fields ที่ไม่จำเป็น

## 🎯 Use Cases ในโลกจริง

- **Data Migration**: เปรียบเทียบข้อมูลระหว่าง legacy และ modern systems
- **Database Synchronization**: sync เฉพาะ fields ที่สำคัญ
- **Cross-Platform Comparison**: เปรียบเทียบข้อมูลระหว่าง database vendors ที่แตกต่างกัน
- **Selective Validation**: ตรวจสอบเฉพาะข้อมูลหลักโดยไม่สนใจ metadata fields

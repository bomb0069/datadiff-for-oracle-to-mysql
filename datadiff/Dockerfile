FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    libaio1t64 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir "data-diff==0.10.0" mysql-connector-python oracledb "pydantic<2" pymysql

WORKDIR /scripts
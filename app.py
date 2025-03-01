import pymysql
import pandas as pd
import os

# Database connection details (update as needed)
db_config = {
    "host": "localhost",
    "user": "root",    # Replace with your MySQL username
    "password": "john", # Replace with your MySQL password
    "database": "adidas"
}

# Path to your CSV file
csv_file_path = os.path.join("Source Files", "adidas.csv")  # Ensure the filename matches

# Connect to MySQL
conn = pymysql.connect(**db_config)
cursor = conn.cursor()

# Create the sales table if not exists
create_table_query = """
CREATE TABLE IF NOT EXISTS sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(255),
    customer_number INT,
    invoice_date DATE,
    customer_location VARCHAR(255),
    customer_state VARCHAR(100),
    customer_city VARCHAR(100),
    product VARCHAR(255),
    price_per_unit DECIMAL(10,2),
    units_sold INT,
    total_sales DECIMAL(15,2),
    sales_method VARCHAR(50)
);
"""
cursor.execute(create_table_query)
conn.commit()

# Read CSV file using pandas
df = pd.read_csv(csv_file_path, delimiter="\t")  # Ensure correct delimiter if needed

# Convert date format and remove currency symbols
df["Invoice Date"] = pd.to_datetime(df["Invoice Date"], format="%m/%d/%Y")
df["Price per Unit"] = df["Price per Unit"].replace('[\$,]', '', regex=True).astype(float)
df["Total Sales"] = df["Total Sales"].replace('[\$,]', '', regex=True).astype(float)

# Insert data into MySQL
insert_query = """
INSERT INTO sales (customer_name, customer_number, invoice_date, customer_location, customer_state, customer_city, product, price_per_unit, units_sold, total_sales, sales_method) 
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
"""

# Convert DataFrame to list of tuples for insertion
data_to_insert = df.values.tolist()
cursor.executemany(insert_query, data_to_insert)
conn.commit()

print("Data successfully inserted into the MySQL database!")

# Close the connection
cursor.close()
conn.close()

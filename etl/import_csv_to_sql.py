import pyodbc
import pandas as pd


# Read CSV file
df_offers = pd.read_csv('~/development/retail/data/offers.csv')
df_product = pd.read_csv('~/development/retail/data/product.csv')
df_sales = pd.read_csv('~/development/retail/data/sales.csv')


# SQL Server connection
server = 'localhost,1433' 
database = 'retail' 
username = 'sa' 
password = 'sqlPassword@3' 

cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()


# Insert Dataframes into SQL Server:
for index, row in df_offers.iterrows():
     cursor.execute("INSERT INTO offers (id_offer,offer_desc) values(?,?)", row.ID, row.DESC)

for index, row in df_product.iterrows():
    cursor.execute("INSERT INTO product (id_prod,id_cat) values(?,?)", int(row.id_prod), int(row.id_cat))

for index, row in df_sales.iterrows():
     cursor.execute("INSERT INTO sales (id_cte,id_prod) values(?,?)", row.id_cte, int(row.id_prod))

cnxn.commit()

cursor.close()

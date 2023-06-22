import sys
!{sys.executable} -m pip install pyodbc


import pyodbc
server = '192.168.3.42:1433' 
database = 'retail' 
username = 'sa' 
password = 'Pru3b@docker' 
cnxn_str = ("Driver={SQL Server Native Client 11.0};"
            "Server=192.168.3.42:,433;"
            "Database=retail;"
            "UID=sa;"
            "PWD=Pru3b@docker")
cnxn = pyodbc.connect(cnxn_str)


#Sample insert query
count = cursor.execute("""
INSERT INTO SalesLT.Product (Name, ProductNumber, StandardCost, ListPrice, SellStartDate) 
VALUES (?,?,?,?,?)""",
'SQL Server Express New 20', 'SQLEXPRESS New 20', 0, 0, CURRENT_TIMESTAMP).rowcount
cnxn.commit()
print('Rows inserted: ' + str(count))
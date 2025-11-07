CREATE DATABASE CollegeDB;
USE CollegeDB;

CREATE TABLE STUDENT (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);

import mysql.connector

# Connect to MySQL
con = mysql.connector.connect(
    host="localhost",
    user="root",        # change if needed
    password="",        # your MySQL password
    database="CollegeDB"
)
cur = con.cursor()

def add_student():
    roll = int(input("Enter Roll No: "))
    name = input("Enter Name: ")
    age = int(input("Enter Age: "))
    cur.execute("INSERT INTO STUDENT VALUES (%s, %s, %s)", (roll, name, age))
    con.commit()
    print("Record Added Successfully!")

def view_students():
    cur.execute("SELECT * FROM STUDENT")
    for row in cur.fetchall():
        print(row)

def edit_student():
    roll = int(input("Enter Roll No to Edit: "))
    new_name = input("Enter New Name: ")
    cur.execute("UPDATE STUDENT SET name=%s WHERE roll_no=%s", (new_name, roll))
    con.commit()
    print("Record Updated Successfully!")

def delete_student():
    roll = int(input("Enter Roll No to Delete: "))
    cur.execute("DELETE FROM STUDENT WHERE roll_no=%s", (roll,))
    con.commit()
    print("Record Deleted Successfully!")

# Menu
while True:
    print("\n--- Student Database Menu ---")
    print("1. Add Student")
    print("2. View Students")
    print("3. Edit Student")
    print("4. Delete Student")
    print("5. Exit")
    choice = input("Enter choice: ")

    if choice == '1':
        add_student()
    elif choice == '2':
        view_students()
    elif choice == '3':
        edit_student()
    elif choice == '4':
        delete_student()
    elif choice == '5':
        break
    else:
        print("Invalid Choice!")

con.close()

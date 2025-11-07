// Step 1: Use or Create Database
use hospitalDB

// Step 2: Insert 8 patient records
db.patients.insertMany([
  { pid: 1, pname: "Amit", age: 35, disease: "Fever", city: "Nashik", charges: 1500 },
  { pid: 2, pname: "Sneha", age: 42, disease: "Diabetes", city: "Pune", charges: 5000 },
  { pid: 3, pname: "Rohit", age: 29, disease: "Fever", city: "Mumbai", charges: 1200 },
  { pid: 4, pname: "Priya", age: 33, disease: "COVID", city: "Pune", charges: 8000 },
  { pid: 5, pname: "Karan", age: 46, disease: "Asthma", city: "Nashik", charges: 3500 },
  { pid: 6, pname: "Nisha", age: 51, disease: "Diabetes", city: "Mumbai", charges: 4000 },
  { pid: 7, pname: "Vikas", age: 38, disease: "COVID", city: "Pune", charges: 7500 },
  { pid: 8, pname: "Riya", age: 27, disease: "Fever", city: "Nashik", charges: 1800 }
]);

// Step 3: Create index on disease and city
db.patients.createIndex({ disease: 1 });
db.patients.createIndex({ city: 1 });

// Step 4: Find average hospital charges per disease
db.patients.aggregate([
  { $group: { _id: "$disease", avgCharges: { $avg: "$charges" } } }
]);

// Step 5: Find total charges per city
db.patients.aggregate([
  { $group: { _id: "$city", totalCharges: { $sum: "$charges" } } }
]);

// Step 6: Display patients grouped by city
db.patients.aggregate([
  { $group: { _id: "$city", patients: { $push: "$pname" } } }
]);

// Step 7: Sort cities by total charges in descending order
db.patients.aggregate([
  { $group: { _id: "$city", totalCharges: { $sum: "$charges" } } },
  { $sort: { totalCharges: -1 } }
]);

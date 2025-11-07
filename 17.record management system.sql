// Step 1: Use or Create Database
use collegeDB

// Step 2: Insert 8 student records
db.students.insertMany([
  { roll_no: 1, name: "Amit", dept: "CSE", marks: 85, city: "Nashik" },
  { roll_no: 2, name: "Sneha", dept: "IT", marks: 78, city: "Pune" },
  { roll_no: 3, name: "Raj", dept: "CSE", marks: 92, city: "Mumbai" },
  { roll_no: 4, name: "Priya", dept: "ENTC", marks: 66, city: "Nashik" },
  { roll_no: 5, name: "Karan", dept: "IT", marks: 88, city: "Pune" },
  { roll_no: 6, name: "Nisha", dept: "ENTC", marks: 73, city: "Pune" },
  { roll_no: 7, name: "Vikas", dept: "CSE", marks: 69, city: "Nashik" },
  { roll_no: 8, name: "Riya", dept: "IT", marks: 95, city: "Mumbai" }
]);

// Step 3: Create index on dept and marks
db.students.createIndex({ dept: 1 });
db.students.createIndex({ marks: -1 });

// Step 4: Calculate average marks department-wise
db.students.aggregate([
  { $group: { _id: "$dept", avgMarks: { $avg: "$marks" } } }
]);

// Step 5: Find highest scorer in each department
db.students.aggregate([
  { $group: { _id: "$dept", maxMarks: { $max: "$marks" } } }
]);

// Step 6: Find students with marks > 70 and sort by name
db.students.find({ marks: { $gt: 70 } }).sort({ name: 1 });

// Step 7: Display total number of students from each city
db.students.aggregate([
  { $group: { _id: "$city", totalStudents: { $sum: 1 } } }
]);
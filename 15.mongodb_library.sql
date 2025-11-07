// Step 1: Create / Switch to database
use libraryDB

// Step 2: Create Collection and Insert Records
db.books.insertMany([
  { _id: 1, title: "DBMS Concepts", author: "Korth", price: 500, copies: 10, category: "Database" },
  { _id: 2, title: "Operating System", author: "Galvin", price: 450, copies: 6, category: "System" },
  { _id: 3, title: "C Programming", author: "Dennis Ritchie", price: 300, copies: 15, category: "Programming" },
  { _id: 4, title: "Data Structures", author: "Narasimha Karumanchi", price: 550, copies: 3, category: "Programming" },
  { _id: 5, title: "Computer Networks", author: "Tanenbaum", price: 700, copies: 8, category: "Networking" }
]);

// Step 3: Display all books
db.books.find();

// Step 4: Display books where price > 400
db.books.find({ price: { $gt: 400 } });

// Step 5: Display books where category is either “Database” or “Programming”
db.books.find({ category: { $in: ["Database", "Programming"] } });

// Step 6: Update price of a specific book (for example, book id=3)
db.books.updateOne(
  { _id: 3 },
  { $set: { price: 350 } }
);

// Step 7: Delete all books with less than 5 copies
db.books.deleteMany({ copies: { $lt: 5 } });

// Step 8: Use save() method to modify or insert a document
db.books.save({ _id: 6, title: "AI Basics", author: "Russell", price: 900, copies: 5, category: "AI" });